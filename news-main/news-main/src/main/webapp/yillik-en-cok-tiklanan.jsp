<%@ page import="com.mycompany.newssites.ClassificationCounter" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <h5 class="card-title">Yıllık En Çok Tıklananlar</h5>
                        <canvas id="yearlyChart" style="max-height: 400px;"></canvas>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                const yearlyData = <%= new com.google.gson.Gson().toJson(ClassificationCounter.getYearlyClassifications()) %>;
                                const labels = yearlyData.map(entry => entry.key);
                                const dataValues = yearlyData.map(entry => entry.value);

                                // Belirli bir renk paleti
                                const colorPalette = [
                                    'rgb(255, 99, 132)', // Kırmızı
                                    'rgb(54, 162, 235)', // Mavi
                                    'rgb(255, 205, 86)', // Sarı
                                    'rgb(75, 192, 192)', // Turkuaz
                                    'rgb(153, 102, 255)', // Mor
                                    'rgb(255, 159, 64)', // Turuncu
                                    'rgb(255, 205, 86)', // Açık Sarı
                                    'rgb(100, 149, 237)', // Cornflower Blue
                                    'rgb(0, 255, 127)', // Yeşil
                                    'rgb(210, 105, 30)'  // Çikolata
                                    // Daha fazla renk ekleyebilirsiniz
                                ];

                                // Renkleri sınıf sayısına göre ayarlama
                                const backgroundColors = labels.map((_, index) => colorPalette[index % colorPalette.length]);

                                new Chart(document.querySelector('#yearlyChart'), {
                                    type: 'doughnut',
                                    data: {
                                        labels: labels,
                                        datasets: [{
                                            data: dataValues,
                                            backgroundColor: backgroundColors,
                                            hoverOffset: 4
                                        }]
                                    },
                                    options: {
                                        plugins: {
                                            legend: {
                                                display: false // Legend'i gizle
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
