package com.mailsender;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {

    public static void main(String[] args) {

    }

    public void mailSender(String mail, String subject, String mesaj) {
        String to = mail; // Alıcının e-posta adresi
        String from = "haberarsivdestek@gmail.com"; // Gönderenin e-posta adresi
        final String username = "haberarsivdestek@gmail.com"; // Gönderenin e-posta adresi
        final String password = "ddbqrkahitexwvmy"; // Buraya uygulama şifresini yazın

        // SMTP sunucusu ayarları
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); // SMTP sunucu adresi
        properties.put("mail.smtp.port", "587"); // SMTP port numarası

        // Oturum oluşturma
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Mesaj oluşturma
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(mesaj); 

            // E-posta gönderme
            Transport.send(message);
            System.out.println("E-posta başarıyla gönderildi!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
