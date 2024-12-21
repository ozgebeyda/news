<%@page import="com.mailsender.EmailSender"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="java.io.IOException"%>

<!DOCTYPE html>
<html lang="tr">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dijital Arşiv</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <jsp:include page="head.jsp"/>
    <style>
        #validationTooltip05 {
            width: 368px;
        }

        #validationTooltip06 {
            width: 720px;
        }
    </style>

</head>

<body>
    <jsp:include page="header.jsp"/>
    <jsp:include page="sidebar.jsp"/>
    <main id="main" class="main">

<section class="section">
    <div class="row justify-content-center align-items-center" style="height: 100vh;">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Aldığınız Hataları Aşağıdaki Form ile Bize Gönderin. <br> <br> Size Daha İyi Bir Deneyim Sunalım.</h5>

                    <div id="alert" class="alert alert-secondary alert-dismissible fade show" role="alert" style="display:none;">
                        <i class="bi bi-collection me-1"></i>
                        Gönderim başarılı! Teşekkürler.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>

                    <form id="feedbackForm" class="row g-3 needs-validation" method="post" novalidate>
                        <div class="col-md-4 position-relative">
                            <label for="validationTooltip01" class="form-label">İsim Soyisim</label>
                            <input type="text" name="name" class="form-control" id="validationTooltip01" required>
                            <div class="invalid-tooltip">
                                Lütfen isminizi ve soyisminizi girin.
                            </div>
                        </div>

                        <div class="col-md-4 position-relative">
                            <label for="validationTooltip02" class="form-label">Mail Adresi</label>
                            <input type="email" name="email" class="form-control" id="validationTooltip02" required>
                            <div class="invalid-tooltip" id="emailError" style="display:none;">
                                Lütfen geçerli bir mail adresi girin (örn: user@example.com).
                            </div>
                        </div>

                        <div class="col-md-4 position-relative">
                            <label for="validationTooltip04" class="form-label">Konu</label>
                            <select name="subject" class="form-select" id="validationTooltip04" required>
                                <option selected disabled value="">Seçiniz</option>
                                <option value="arayuz_sorunlari">Arayüz Sorunları</option>
                                <option value="haber_ekleme">Haber Sitesi Ekleme</option>
                                <option value="hatalı_yazi">Hatalı Yazı</option>
                                <option value="calismayan_link">Çalışmayan Link</option>
                                <option value="oneriler">Öneri ve Geri Bildirim</option>
                                <option value="digertopikler">Diğer Konular</option>
                            </select>
                            <div class="invalid-tooltip">
                                Lütfen bir konu seçin.
                            </div>
                        </div>

                        <div class="col-md-8 position-relative">
                            <label for="validationTooltip06" class="form-label">Açıklama</label>
                            <textarea name="explanation" class="form-control" id="validationTooltip06" rows="3" required></textarea>
                            <div class="invalid-tooltip">
                                Lütfen açıklamanızı girin.
                            </div>
                        </div>

                        <div class="col-12">
                            <button class="btn btn-primary" type="submit">Gönder</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String explanation = request.getParameter("explanation");

    if (name != null && email != null && subject != null && explanation != null) {
        try {
         EmailSender emailsender = new EmailSender();
        String kullaniciSubject = "Geri Bildirim";
        String kullaniciMesaj = "Merhaba " + name + ".\n"
                      + "Geri dönüşlerin bizim için çok değerli. \n"
                      + "Sizlerden gelen her bir mesaj, hizmetimizi geliştirmek için büyük bir fırsat. \n"
                      + "Ekibimiz, yakın gelecekte kullanıcılarımıza daha iyi bir deneyim sunmak amacıyla çalışıyor. \n"
                      + "Bu süreçte, önerileriniz ve düşünceleriniz bizim için oldukça önemli. \n"
                      + "Unutmayın ki, sizin memnuniyetiniz bizim önceliğimizdir. \n"
                      + "Eğer herhangi bir sorunuz veya öneriniz varsa, lütfen bizimle paylaşmaktan çekinmeyin. \n"
                      + "İyi günler :)";
        emailsender.mailSender(email, kullaniciSubject, kullaniciMesaj);

        String ownerEmail = "ozgebeyda@hotmail.com";
        String ownerSubject = subject + " Hatası";
        String ownerMesaj = explanation + "\n Gönderen : " + email;
        emailsender.mailSender(ownerEmail, ownerSubject, ownerMesaj);
            MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
            MongoDatabase database = mongoClient.getDatabase("news");
            MongoCollection<Document> collection = database.getCollection("mail");

            Document feedbackDocument = new Document("name", name)
                    .append("email", email)
                    .append("subject", subject)
                    .append("explanation", explanation);

            collection.insertOne(feedbackDocument);
            mongoClient.close();
%>
            <script>
                document.getElementById('alert').style.display = 'block';
            </script>
<%
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert("Veritabanına kayıt sırasında bir hata oluştu.");
            </script>
<%
        }
    }
%>

</main>

<jsp:include page="footer.jsp"/>  

<jsp:include page="scriptjs.jsp"/>

<script>
    document.getElementById('feedbackForm').addEventListener('submit', function(event) {
        event.preventDefault();

        var valid = true;
        var emailInput = document.getElementById('validationTooltip02');
        var emailError = document.getElementById('emailError');

        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(emailInput.value)) {
            valid = false;
            emailError.style.display = 'block';
        } else {
            emailError.style.display = 'none';
        }

        var inputs = this.querySelectorAll('input[required], textarea[required], select[required]');
        inputs.forEach(function(input) {
            if (!input.value) {
                valid = false;
            }
        });

        if (valid) {
            this.submit(); // Geçerli ise formu gönder
        }
    });
</script>

</body>

</html>
