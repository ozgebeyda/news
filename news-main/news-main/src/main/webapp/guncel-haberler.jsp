<%@page import="com.mycompany.newssites.MongoDBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.util.List"%>
<%@page import="org.bson.Document"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dijital Arşiv</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <jsp:include page="head.jsp"/>

    <style>
        .carousel-container {
            display: flex;
            justify-content: center; 
            padding: 20px 0; 
        }

        .carousel {
            width: 100%;
            max-width: 1200px; 
        }

        .carousel-inner img {
            width: 100%; 
            height: auto; 
            border-radius: 25px; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: #000; 
            border-radius: 50%;
            padding: 15px; 
            opacity: 0.8;
        }

        .carousel-control-prev-icon:hover,
        .carousel-control-next-icon:hover {
            background-color: #007bff;
        }

        .carousel-caption h5 {
            background-color: rgba(0, 0, 0, 0.5); 
            padding: 10px;
            border-radius: 10px;
        }

        .carousel-caption p {
            background-color: rgba(0, 0, 0, 0.3);
            padding: 5px;
            border-radius: 10px;
        }

        .custom-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .custom-card-wrapper {
            width: 48%;
        }

        .custom-card {
            background-color: #f8f9fa;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }

        .custom-card img {
            border-radius: 15px;
            width: 100px;
            height: auto;
            margin-right: 10px;
        }

        @media (max-width: 768px) {
            .custom-card-wrapper {
                width: 100%;
            }
        }

        .custom-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            align-items: stretch; 
        }

        .custom-card-wrapper {
            padding: 0;
            margin: 0;
            width: 48%; 
            display: flex;
        }

        .custom-card {
            background-color: #f8f9fa;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            align-items: center;
            width: 100%;
            flex-grow: 1; 
        }

        .custom-card img {
            border-radius: 15px;
            width: 100px;
            height: auto;
            margin-right: 10px;
        }

        .custom-card-body {
            padding: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center; 
            flex-grow: 1; 
        }

        @media (max-width: 768px) {
            .custom-card-wrapper {
                width: 100%; 
            }
        }
        .custom-card img {
            border-radius: 15px;
            width: 100px;
            height: 100px;
            margin-right: 15px; 
            margin-left: 10px; 
        }

    </style>
</head>

<body>
    <jsp:include page="header.jsp"/>

    <jsp:include page="sidebar.jsp"/>

    <%
        String topic = "";
        if (request.getParameter("page") != null) {
            switch (request.getParameter("page")) {
                case "astroloji":
                    topic = "Astroloji";
                    break;
                case "bilim":
                    topic = "Bilim";
                    break;
                case "egitim":
                    topic = "Egitim";
                    break;
                case "ekonomi":
                    topic = "Ekonomi";
                    break;
                case "emlak":
                    topic = "Emlak";
                    break;
                case "kultur":
                    topic = "Kultur ve Sanat";
                    break;
                case "magazin":
                    topic = "Magazin";
                    break;
                case "moda":
                    topic = "Moda";
                    break;
                case "politika":
                    topic = "Politika";
                    break;
                case "saglik":
                    topic = "Saglik";
                    break;
                case "seyahat":
                    topic = "Seyahat";
                    break;
                case "spor":
                    topic = "Spor";
                    break;
                case "teknoloji":
                    topic = "Teknoloji";
                    break;
                case "trafik":
                    topic = "Trafik";
                    break;
                case "yasam":
                    topic = "Yasam";
                    break;
            }
        }
    %>

<main id="main" class="main">
    <div class="carousel-container">
        <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <%
                    MongoDBUtil mongoDBUtil = new MongoDBUtil();
                    List<Document> documents = mongoDBUtil.getAllNews("", "", "", topic, 20, 0);
                    for (int i = 0; i < 10 && i < documents.size(); i++) {
                        if (i == 0) {
                %>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="<%= i%>" class="active" aria-current="true" aria-label="Slide <%= i + 1%>"></button>
                <% } else {%>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="<%= i%>" aria-label="Slide <%= i + 1%>"></button>
                <% }
                    } %>
            </div>
            <div class="carousel-inner">
                <%
                    for (int i = 0; i < 10 && i < documents.size(); i++) {
                        Document doc = documents.get(i);
                        String photograph = doc.getString("photograph");
                        String title = doc.getString("title");
                        String link = doc.getString("link");
                        if (i == 0) {
                %>
                <div class="carousel-item active">
                    <a href="<%= link%>">
                        <img src="<%= photograph%>" class="d-block w-100" alt="...">
                    </a>
                    <div class="carousel-caption d-none d-md-block">
                        <h5><%= title%></h5>
                        <p>Some representative placeholder content for the first slide.</p>
                    </div>
                </div>
                <% } else {%>
                <div class="carousel-item">
                    <a href="<%= link%>">
                        <img src="<%= photograph%>" class="d-block w-100" alt="...">
                    </a>
                    <div class="carousel-caption d-none d-md-block">
                        <h5><%= title%></h5>
                        <p>Some representative placeholder content for this slide.</p>
                    </div>
                </div>
                <% }
                    } %>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <section class="custom-section">
        <div class="custom-row">
            <%
                for (int i = 10; i < documents.size(); i++) {
                    Document doc = documents.get(i);
                    String photograph = doc.getString("photograph");
                    String title = doc.getString("title");
                    String content = doc.getString("content");
                    String link = doc.getString("link");
            %>
            <div class="custom-card-wrapper">
                <div class="custom-card mb-3">
                    <a href="<%= link%>">
                        <img src="<%= photograph%>" alt="Card <%= i + 1%>">
                    </a>
                    <div class="custom-card-body">
                        <h5 class="card-title"><%= title%></h5>
                        <p class="card-text"><%= content%></p>
                    </div>
                </div>
            </div>
            <% }%>
        </div>
    </section>
</main>

<jsp:include page="footer.jsp"/>  
<jsp:include page="scriptjs.jsp"/>
</body>

</html>
