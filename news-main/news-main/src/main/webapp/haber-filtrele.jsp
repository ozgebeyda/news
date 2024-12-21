<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mycompany.newssites.NewsFetcher"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Haber Listesi</title>
    <jsp:include page="head.jsp"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: auto;
            max-width: 1500px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .filters {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            gap: 10px;
            flex-wrap: wrap; /* Ekleme: Öğelerin alt satıra geçmesini sağlar */
        }
        .filters input, .filters select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            flex: 1;
            margin: 0 5px;
            min-width: 150px;
        }
        .filters input[type="submit"] {
            flex: 0; /* Ekleme: Butonun genişliğini otomatik ayarlamaktan çıkarır */
        }
        table th {
            background-color: #f2f2f2;
            text-align: center;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
            display: flex; /* Ekleme */
            justify-content: center; /* Ekleme */
            flex-wrap: wrap; /* Ekleme: Butonların alt satıra geçmesini sağlar */
        }
        .pagination a {
            display: inline-block;
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #0056b3;
        }
        
    </style>
</head>

<body>
    <jsp:include page="header.jsp"/>
    <jsp:include page="sidebar.jsp"/>

<main id="main" class="main">
    <div class="container">
        <h1>Haber Listesi</h1>
        <div class="filters">
            <form method="get" style="display: flex; justify-content: center; flex-wrap: wrap;">
                <input type="text" name="searchTitle" placeholder="Başlıkta arama yap..." value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : ""%>">
                    <input type="date" name="publishDate" value="<%= request.getParameter("publishDate") != null ? request.getParameter("publishDate") : ""%>">
                        <select name="siteName">
                            <option value="">Tüm Siteler</option>
                            <%
                                NewsFetcher newsFetcher = new NewsFetcher();
                                List<String> uniqueSiteNames = newsFetcher.fetchUniqueSiteNames();
                                String selectedSiteName = request.getParameter("siteName");
                                for (String siteName : uniqueSiteNames) {
                            %>
                            <option value="<%= siteName%>" <%= (siteName.equals(selectedSiteName)) ? "selected" : ""%>><%= siteName%></option>
                            <% } %>
                        </select>
                        <select name="classification">
                            <option value="">Tüm Konular</option>
                            <%
                                List<String> uniqueClassifications = newsFetcher.fetchUniqueClassifications();
                                String selectedClassification = request.getParameter("classification");
                                for (String classification : uniqueClassifications) {
                            %>
                            <option value="<%= classification%>" <%= (classification.equals(selectedClassification)) ? "selected" : ""%>><%= classification%></option>
                            <% } %>
                        </select>
                        <input type="submit" value="Filtrele" style="flex: 0;">
                            </form>
                            </div>

                            <table>
                                <thead>
                                    <tr>
                                        <th>Başlık</th>
                                        <th>İçerik</th>
                                        <th>Yayınlanma Tarihi</th>
                                        <th>Site Adı</th>
                                        <th>Dil</th>
                                        <th>Konu</th>
                                        <th>Detay</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int pageSize = 10;
                                        int currentPage = 1;
                                        if (request.getParameter("page") != null) {
                                            currentPage = Integer.parseInt(request.getParameter("page"));
                                        }

                                        String searchTitle = request.getParameter("searchTitle");
                                        String publishDateStr = request.getParameter("publishDate");
                                        String siteName = request.getParameter("siteName");
                                        String classification = request.getParameter("classification");
                                        Date publishDate = null;

                                        if (publishDateStr != null && !publishDateStr.isEmpty()) {
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                            publishDate = dateFormat.parse(publishDateStr);
                                        }

                                        long totalNewsCount = newsFetcher.getTotalNewsCount(searchTitle, publishDate, siteName, classification);
                                        int totalPages = (int) Math.ceil((double) totalNewsCount / pageSize);

                                        List<Document> newsList = newsFetcher.fetchNews(searchTitle, publishDate, siteName, classification, currentPage, pageSize);
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                                        for (Document news : newsList) {
                                            String title = news.getString("title");
                                            String content = news.getString("content");
                                            Date publicationDate = news.getDate("publication_date");
                                            String siteNameFromDoc = news.getString("site_name");
                                            String language = news.getString("language");
                                            String classificationFromDoc = news.getString("classification");
                                            String detailContent = news.getString("detail_content") != null ? news.getString("detail_content") : "N/A";
                                    %>
                                    <tr>
                                        <td><%= title%></td>
                                        <td><%= content%></td>
                                        <td><%= (publicationDate != null ? dateFormat.format(publicationDate) : "N/A")%></td>
                                        <td><%= siteNameFromDoc%></td>
                                        <td><%= language%></td>
                                        <td><%= classificationFromDoc%></td>
                                        <td>
                                            <a href="detay.jsp?id=<%= news.getObjectId("_id").toString()%>" target="_blank">Daha Fazlası...</a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>

                            <!-- Sayfalama -->
                            <!-- Sayfalama -->
                            <div class="pagination">
                                <% if (currentPage > 1) {%>
                                <a href="?searchTitle=<%= searchTitle != null ? searchTitle : ""%>&publishDate=<%= publishDateStr != null ? publishDateStr : ""%>&siteName=<%= siteName != null ? siteName : ""%>&classification=<%= classification != null ? classification : ""%>&page=<%= currentPage - 1%>">&laquo; Önceki</a>
                                <% } %>

                                <%
                                    int startPage = Math.max(1, currentPage - 1); // Bir önceki sayfa
                                    int endPage = Math.min(totalPages, currentPage + 1); // Bir sonraki sayfa
                                    for (int i = startPage; i <= endPage; i++) {
                                %>
                                <a href="?searchTitle=<%= searchTitle != null ? searchTitle : ""%>&publishDate=<%= publishDateStr != null ? publishDateStr : ""%>&siteName=<%= siteName != null ? siteName : ""%>&classification=<%= classification != null ? classification : ""%>&page=<%= i%>"
                                   class="<%= (i == currentPage) ? "active" : ""%>"><%= i%></a>
                                <% } %>

                                <% if (currentPage < totalPages) {%>
                                <a href="?searchTitle=<%= searchTitle != null ? searchTitle : ""%>&publishDate=<%= publishDateStr != null ? publishDateStr : ""%>&siteName=<%= siteName != null ? siteName : ""%>&classification=<%= classification != null ? classification : ""%>&page=<%= currentPage + 1%>">Sonraki &raquo;</a>
                                <% }%>

                                <!-- Sayfa Seçimi -->
                                <form method="get" style="display: inline-block; margin-left: 10px;">
                                    <input type="hidden" name="searchTitle" value="<%= searchTitle != null ? searchTitle : ""%>">
                                        <input type="hidden" name="publishDate" value="<%= publishDateStr != null ? publishDateStr : ""%>">
                                            <input type="hidden" name="siteName" value="<%= siteName != null ? siteName : ""%>">
                                                <input type="hidden" name="classification" value="<%= classification != null ? classification : ""%>">
                                                    <select name="page" onchange="this.form.submit()" style="padding: 5px; border-radius: 4px; border: 1px solid #ccc;">
                                                        <% for (int i = 1; i <= totalPages; i++) {%>
                                                        <option value="<%= i%>" <%= (i == currentPage) ? "selected" : ""%>><%= i%></option>
                                                        <% }%>
                                                    </select>
                                                    <noscript>
                                                        <input type="submit" value="Git">
                                                    </noscript>
                                                    </form>
                                                    </div>


                                                    </div>
                                                    </main>

                                                    <jsp:include page="footer.jsp"/>
                                                    </body>

                                                    </html>
