<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="path/to/your/bootstrap-icons.css"> <!-- Bootstrap Icons için -->
    <link rel="stylesheet" href="path/to/your/styles.css"> <!-- CSS dosyanızı ekleyin -->
</head>
<body>
    <aside id="sidebar" class="sidebar">
        <ul class="sidebar-nav" id="sidebar-nav">
            <!-- Üst Bölüm: Güncel Haberler, Haber Filtreleme, İstatistikler -->
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=guncel">
                    <i class="bi bi-newspaper"></i>
                    <span>Güncel Haberler</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="haber-filtrele.jsp">
                    <i class="bi bi-funnel"></i>
                    <span>Haber Filtrele</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="istatistik.jsp">
                    <i class="bi bi-bar-chart"></i>
                    <span>İstatistik</span>
                </a>
            </li>
            <li class="nav-item">
                <hr class="sidebar-divider">
                <span class="nav-link text-muted">Haber Konuları</span>
            </li>
            <!-- Konular Bölümü -->
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=astroloji">
                    <i class="bi bi-stars"></i>
                    <span>Astroloji</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=bilim">
                    <i class="bi bi-lightbulb"></i>
                    <span>Bilim</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=egitim">
                    <i class="bi bi-book"></i>
                    <span>Eğitim</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=ekonomi">
                    <i class="bi bi-cash"></i>
                    <span>Ekonomi</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=emlak">
                    <i class="bi bi-house"></i>
                    <span>Emlak</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=kultur">
                    <i class="bi bi-palette"></i>
                    <span>Kültür ve Sanat</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=magazin">
                    <i class="bi bi-camera"></i>
                    <span>Magazin</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=moda">
                    <i class="bi bi-bag"></i>
                    <span>Moda</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=politika">
                    <i class="bi bi-people"></i>
                    <span>Politika</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=saglik">
                    <i class="bi bi-heart"></i>
                    <span>Sağlık</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=seyahat">
                    <i class="bi bi-airplane-engines"></i>
                    <span>Seyahat</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=spor">
                    <i class="bi bi-trophy"></i>
                    <span>Spor</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=teknoloji">
                    <i class="bi bi-laptop"></i>
                    <span>Teknoloji</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=trafik">
                    <i class="bi bi-car-front"></i>
                    <span>Trafik</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="guncel-haberler.jsp?page=yasam">
                    <i class="bi bi-person-circle"></i>
                    <span>Yaşam</span>
                </a>
            </li>
            <li class="nav-item">
                <hr class="sidebar-divider">
                <span class="nav-link text-muted">En Çok Tıklananlar</span>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="haftalik-en-cok-tiklanan.jsp">
                    <i class="bi bi-arrow-repeat"></i>
                    <span>Haftalık En Çok Tıklananlar</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="aylik-en-cok-tiklanan.jsp">
                    <i class="bi bi-arrow-repeat"></i>
                    <span>Aylık En Çok Tıklananlar</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="yillik-en-cok-tiklanan.jsp">
                    <i class="bi bi-arrow-repeat"></i>
                    <span>Yıllık En Çok Tıklananlar</span>
                </a>
            </li>
            <li class="nav-item">
                <hr class="sidebar-divider">
                <span class="nav-link text-muted">İletişim</span>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feedback.jsp">
                    <i class="bi bi-envelope"></i>
                    <span>Hataları Bize Gönderin</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="iletisim.jsp">
                    <i class="bi bi-telephone"></i>
                    <span>İletişim</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="sikca-sorulan-sorular.jsp">
                    <i class="bi bi-question-circle"></i>
                    <span>Sıkça Sorulan Sorular</span>
                </a>
            </li>
        </ul>
    </aside>
</body>
</html>
