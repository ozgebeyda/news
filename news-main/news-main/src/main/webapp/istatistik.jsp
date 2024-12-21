<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.newssites.ClassificationUpdater" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dijital Arşiv</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <jsp:include page="head.jsp"/>
</head>

<body>
    <jsp:include page="header.jsp"/>

    <jsp:include page="sidebar.jsp"/>

<main id="main" class="main">

    <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Haber Grafiği</h5>

                    <canvas id="barChart" style="max-height: 400px;"></canvas>
                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            const labels = [];
                            const dataCounts = [];
                        <%
                                ClassificationUpdater updater = new ClassificationUpdater();
                                List<Document> counts = updater.getClassificationCounts();
                                for (Document doc : counts) {
                                    String classification = doc.getString("_id");
                                    int count = doc.getInteger("count");
                        %>
                            labels.push("<%= classification %>");
                            dataCounts.push(<%= count %>);
                        <% } %>

                            new Chart(document.querySelector('#barChart'), {
                                type: 'bar',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        label: 'Haber Sayısı',
                                        data: dataCounts,
                                        backgroundColor: 'rgba(1, 41, 112, 1)', // Renk ayarı burada
                                        borderColor: 'rgba(1, 41, 112, 1)', // Kenar rengi
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="footer.jsp"/>  

<jsp:include page="scriptjs.jsp"/>
</body>

</html>
