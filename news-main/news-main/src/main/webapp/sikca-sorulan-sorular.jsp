<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mycompany.newssites.MongoDBHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Sıkça Sorulan Sorular</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <meta content="" name="description">
    <meta content="" name="keywords">

    <jsp:include page="head.jsp"/>
    
    <style>
        .card {
            max-width: 800px;
            margin: 0 auto; 
        }

        .accordion-item {
            max-width: 800px; 
            margin: 0 auto;
        }
    </style>

</head>

<body>
    <jsp:include page="header.jsp"/>

    <jsp:include page="sidebar.jsp"/>

    <main id="main" class="main">
        <div class="container">
            <h2 class="text-center my-4">Sıkça Sorulan Sorular</h2> 
            <div class="accordion" id="faq-group-1">
                <%
                    MongoDBHelper mongoDbHelper = new MongoDBHelper();
                    List<Document> questions = mongoDbHelper.getQuestions();
                    for (Document question : questions) {
                        String questionId = question.getObjectId("_id").toString(); 
                %>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="heading<%= questionId %>">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" 
                                    data-bs-target="#collapse<%= questionId %>" 
                                    aria-expanded="false" 
                                    aria-controls="collapse<%= questionId %>">
                                <%= question.getString("soru") %>
                            </button>
                        </h2>
                        <div id="collapse<%= questionId %>" class="accordion-collapse collapse" 
                             aria-labelledby="heading<%= questionId %>" 
                             data-bs-parent="#faq-group-1">
                            <div class="accordion-body">
                                <%= question.getString("cevap") %>
                            </div>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </main>


    <jsp:include page="footer.jsp"/>  

    <jsp:include page="scriptjs.jsp"/>
</body>

</html>
