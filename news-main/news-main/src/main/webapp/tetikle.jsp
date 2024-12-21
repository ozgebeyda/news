<%@page import="com.mycompany.newssites.AnadoluEkspres"%>
<%@page import="com.mycompany.newssites.CnnTurk"%>
<%@page import="com.mycompany.newssites.Cumhuriyet"%>
<%@page import="com.mycompany.newssites.EnSonHaber"%>
<%@page import="com.mycompany.newssites.Haberturk"%>
<%@page import="com.mycompany.newssites.KayseridenHaberler"%>
<%@page import="com.mycompany.newssites.Mynet"%>
<%@page import="com.mycompany.newssites.Ntv"%>
<%@page import="com.mycompany.newssites.ReelSektor"%>
<%@page import="com.mycompany.newssites.RizeTvHaber"%>
<%@page import="com.mycompany.newssites.Sabah"%>
<%@page import="com.mycompany.newssites.SamsundanHaberler"%>
<%@page import="com.mycompany.newssites.SonDakika48"%>
<%@page import="com.mycompany.newssites.Star"%>
<%@page import="com.mycompany.newssites.TrtHaber"%>
<%@page import="com.mycompany.newssites.YeniAkit"%>
<%@page import="com.mycompany.newssites.YeniSafak"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  
            // AnadoluEkspres çalıştır
            AnadoluEkspres a = new AnadoluEkspres();
            a.AnadoluEkspresCalis();

            // CnnTurk çalıştır
            CnnTurk c = new CnnTurk();
            c.CnnTurkCalis();

            // Cumhuriyet çalıştır
            Cumhuriyet cu = new Cumhuriyet();
            cu.CumhuriyetCalis();

            // EnSonHaber çalıştır
            EnSonHaber en = new EnSonHaber();
            en.EnSonHaberCalis();

            // Haberturk çalıştır
            Haberturk h = new Haberturk();
            h.HaberturkCalis();

            // KayseridenHaberler çalıştır
            KayseridenHaberler k = new KayseridenHaberler();
            k.KayseridenHaberlerCalis();

            // Mynet çalıştır
            Mynet my = new Mynet();
            my.MynetCalis();

            // Ntv çalıştır
            Ntv n = new Ntv();
            n.NtvCalis();

            // ReelSektor çalıştır
            ReelSektor r = new ReelSektor();
            r.ReelSektorCalis();

            // RizeTvHaber çalıştır
            RizeTvHaber rz = new RizeTvHaber();
            rz.RizeTvHaberCalis();

            // Sabah çalıştır
            Sabah s = new Sabah();
            s.SabahCalis();

            // SamsundanHaberler çalıştır
            SamsundanHaberler sa = new SamsundanHaberler();
            sa.SamsundanHaberlerCalis();

            // SonDakika48 çalıştır
            SonDakika48 sd = new SonDakika48();
            sd.SonDakika48Calis();

            // Star çalıştır
            Star st = new Star();
            st.StarCalis();

            // TrtHaber çalıştır
            TrtHaber t = new TrtHaber();
            t.TrtHaberCalis();

            // YeniAkit çalıştır
            YeniAkit ya = new YeniAkit();
            ya.YeniAkitCalis();

            // YeniSafak çalıştır
            YeniSafak ys = new YeniSafak();
            ys.YeniSafakCalis();
        %>
    </body>
</html>
