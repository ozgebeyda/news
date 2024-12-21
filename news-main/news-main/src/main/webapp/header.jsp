<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>


<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Dijital Arşiv</title>
    <link rel="stylesheet" href="path/to/your/styles.css"> <!-- CSS dosyan?z?n yolu -->
    <style>
        /* Header stil ayarlar? */
        .header {
            display: flex;
            justify-content: space-between; /* Elemanlar? yan yana da??t?r */
            align-items: center; /* Dikey olarak ortalar */
            padding: 10px 20px; /* Üst ve alt, sa? ve sol bo?luklar */
        }

        .header-title {
            flex-grow: 1; /* Ba?l?k alan?n?n esnemesine izin verir */
            text-align: center; /* Ba?l??? ortalar */
            color: #003366; /* Lacivert renk kodu */
        }

        .logo {
            display: flex; /* Logo bölümünü esnek kutu yapar */
            align-items: center; /* Dikey olarak ortalar */
            margin-left: auto; /* Sol alan? otomatik doldurarak sa?a iter */
        }

        .logo img {
            height: 50px; /* Logonun yüksekli?ini ayarlay?n (gerekti?inde de?i?tirin) */
            margin-left: 10px; /* Logo ile yaz? aras?nda bo?luk */
        }
    </style>
</head>
<body>
    <header id="header" class="header fixed-top d-flex align-items-center">
        <div class="d-flex align-items-center justify-content-between">
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </div>

        <!-- Slogan Section -->
        <div class="header-title">
            Haberin Dijital Arşivi, Bilgiye Açılan Kapı
        </div>

        <!-- Logo Section -->
        <a href="index.jsp" class="logo">
            <span>Dijital Arşiv</span>
            <img src= "assets\img\favicon.png" alt="Dijital Ar?iv Logo">
        </a>
    </header>
</body>
</html>
