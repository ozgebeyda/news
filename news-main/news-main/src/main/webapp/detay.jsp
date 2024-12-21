<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.newssites.NewsFetcher"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Dijital Arşiv - Detay</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow-x: auto;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #0056b3; /* Başlık rengi */
            font-weight: bold; /* Kalın yazı */
        }
        h2 {
            text-align: center; /* Benzer haber başlığı ortalanıyor */
            color: #0056b3; /* Benzer haber başlığı rengi */
            font-weight: bold; /* Kalın yazı */
        }
        .news-photo {
            display: block;
            width: 100%;
            height: auto;
            margin: 0 auto;
        }
        .similar-news-card {
            margin-top: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            display: flex; /* Flexbox kullanarak içerikleri yan yana hizalayalım */
            align-items: center; /* Dikey olarak ortala */
        }
        .similar-news-card img {
            width: 100px; /* Fotoğrafın genişliği */
            height: auto; /* Orantılı yüksekliği koru */
            margin-right: 20px; /* Fotoğraf ile metin arasında boşluk */
        }
        .similar-news-card a {
            display: block;
            color: #007bff;
            text-decoration: none;
        }
        .similar-news-card a:hover {
            text-decoration: underline;
        }
        .news-detail {
            background-color: #f9f9f9; /* Arka plan rengi eklendi */
            padding: 20px; /* İçerik için padding eklendi */
            border-radius: 8px; /* Kenar yuvarlama */
            margin-top: 20px; /* Üstte boşluk */
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp"/>
    <jsp:include page="sidebar.jsp"/>

<main id="main" class="main">
    <div class="container">
        <h1 class="common-style">Haber Detayı</h1> <!-- Kalın ve mavi -->
        <%
            String newsId = request.getParameter("id"); // ID'yi al
            NewsFetcher newsFetcher = new NewsFetcher();
            Document newsDetail = newsFetcher.fetchNewsById(newsId); // ID ile haberi al

            if (newsDetail != null) {
                String title = newsDetail.getString("title");
                String content = newsDetail.getString("content");
                String news_detail = newsDetail.getString("news_detail"); // Detaylı içeriği al
                String siteName = newsDetail.getString("site_name");
                String link = newsDetail.getString("link");
                Date publicationDate = newsDetail.getDate("publication_date");
                String photograph = newsDetail.getString("photograph");
                String classification = newsDetail.getString("classification");

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <img src="<%= photograph%>" alt="Haber Fotoğrafı" class="news-photo"/>
        <br><br>
        <h2><%= title%></h2> <!-- Başlık burada, mavi ama kalın değil -->
        <br>
        <div class="news-detail">
            <p class="site-name"><strong>Site Adı:</strong> <%= siteName%></p>
        </div>
        <div class="news-detail">
            <p><strong>Link:</strong> <a href="<%= link%>" target="_blank">Detaylar</a></p>
        </div>
        <div class="news-detail">
            <p><strong>Yayınlanma Tarihi:</strong> <%= (publicationDate != null ? dateFormat.format(publicationDate) : "N/A")%></p>
        </div>
        <div class="news-detail">
            <p><strong>Sınıflandırma:</strong> <%= classification%></p>
        </div>
        <div class="news-detail">
            <p><strong>İçerik:</strong> <%= content%></p>
        </div>
        <div class="news-detail">
            <p><strong>Detay:</strong> <%= news_detail%></p>
        </div>
    </div>
</div>

<div class="container">
    <h2>Benzer Haber</h2> <!-- Kalın ve mavi -->
    <%
        // Benzer haber için sınıflandırmayı da alıyoruz
        Document mostSimilarNews = newsFetcher.fetchMostSimilarNews(newsId, content, classification); // En benzer haberi al

        if (mostSimilarNews != null) {
            String similarTitle = mostSimilarNews.getString("title");
            String similarContent = mostSimilarNews.getString("content");
            String similarClassification = mostSimilarNews.getString("classification");
            String similarPhotograph = mostSimilarNews.getString("photograph");
            String similarLink = "detay.jsp?id=" + mostSimilarNews.getObjectId("_id").toHexString(); // Benzer haberin detay bağlantısı
    %>
    <div class="similar-news-card">
        <img src="<%= similarPhotograph%>" alt="Benzer Haber Fotoğrafı">
            <div>
                <a href="<%= similarLink%>"><strong><%= similarTitle%></strong></a>
                <p><strong>Sınıflandırma:</strong> <%= similarClassification%></p>
                <p><%= similarContent%></p>
            </div>
    </div>
    <%
    } else {
    %>
    <p>Benzer haber bulunamadı.</p>
    <%
        }
    %>
</div>

<%
} else {
%>
<p>Haber bulunamadı.</p>
<%
    }
%>
</div>
</main>

<jsp:include page="footer.jsp"/>
</body>
</html>
