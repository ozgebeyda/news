<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dijital Arşiv</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <jsp:include page="head.jsp"/>

    <link rel="stylesheet" href="css/all.css"> 

    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        main {
            flex: 1; 
        }

        .footer {
            padding: 20px 0;
            font-size: 14px;
            transition: all 0.3s;
            border-top: 1px solid #cddfff;
        }

        .footer .copyright {
            text-align: center;
            color: #012970;
        }

        .footer .credits {
            padding-top: 5px;
            text-align: center;
            font-size: 13px;
            color: #012970;
        }

        .card {
            border: 1px solid #cddfff;
            border-radius: 8px;
            padding: 20px;
            margin: 20px auto;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 900px;
            max-width: 500px;
        }

        .card h3 {
            color: #012970;
        }

        .contact-section {
            margin: 20px 0;
        }

        .social-icons a {
            margin: 0 10px;
            display: inline-block;
        }

        .social-icons img {
            width: 24px; 
            height: 24px; 
        }
    </style>
</head>

<body>
    <main id="main" class="main">

        <jsp:include page="header.jsp"/>

        <jsp:include page="sidebar.jsp"/>

        <div class="contact-section">
            <div class="card">
                <h2>İletişim Bilgilerim</h2>
                <div class="contact-info">
                    <p><strong>İsim:</strong> Özge Beyda Köpüren</p>
                    <p><strong>E-posta:</strong> <a href="mailto:ozgebeyda@hotmail.com">ozgebeyda@hotmail.com</a></p>
                    <p><strong>Telefon:</strong> <a href="tel:+905072016019">507 201 60 19</a></p>
                    <p><strong>Fax:</strong> +90 312 386 10 93</p>
                    <p><strong>Adres:</strong> OSTİM Teknik Üniversitesi, OSTİM 06374 Ankara</p>
                </div>
            </div>
        </div>

        <div class="contact-section">
            <div class="card">
                <h2>Sosyal Medya</h2>
                <div class="social-icons">
                    <a href="https://www.instagram.com/ozgebeyda/?next=%2F" target="_blank">
                        <img src="assets\img\instagram.png" alt="Instagram">
                    </a>
                    <a href="https://www.linkedin.com/notifications/?filter=all" target="_blank">
                        <img src="assets\img\linkedin.png" alt="LinkedIn">
                    </a>
                    <a href="https://x.com/BeydaKpren" target="_blank">
                        <img src="assets\img\twitter.png" alt="Twitter">
                    </a>
                    <a href="https://www.youtube.com/channel/UC-FnHg8FWopWfHz71PpWoEQ" target="_blank">
                        <img src="assets\img\youtube.png" alt="YouTube">
                    </a>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp"/>  

    <jsp:include page="scriptjs.jsp"/>
</body>

</html>
