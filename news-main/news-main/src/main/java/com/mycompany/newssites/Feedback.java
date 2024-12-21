package com.mycompany.newssites;

import com.mailsender.EmailSender;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

public class Feedback {

    public void saveFeedback(String name, String email, String subject, String explanation) {
        try {
            EmailSender emailsender = new EmailSender();
            String kullaniciSubject = "Geri Bildirim";
            String kullaniciMesaj = "Merhaba " + name + ". Geri dönüşlerin bizim için çok değerli. Yakın gelecekte kullanıcılarımıza daha iyi bir deneyim sunacağız. İyi günler.";
            emailsender.mailSender(email, kullaniciSubject, kullaniciMesaj);

            String ownerEmail = "ozgebeyda@hotmail.com";
            String ownerSubject = subject + " Hatası";
            String ownerMesaj = explanation + "\n Gönderen : " + email;
            emailsender.mailSender(ownerEmail, ownerSubject, ownerMesaj);

            MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017"); // Bağlantı adresinizi buraya yazın
            MongoDatabase database = mongoClient.getDatabase("news"); // Veritabanı ismi
            MongoCollection<Document> collection = database.getCollection("mail"); // Geri bildirim koleksiyonu

            // Girdi verisini belgeye dönüştür
            Document feedbackDocument = new Document("name", name)
                    .append("email", email)
                    .append("subject", subject)
                    .append("explanation", explanation); // Açıklamayı ekleyin

            // Belgeyi koleksiyona ekle
            collection.insertOne(feedbackDocument);

            mongoClient.close();

        } catch (Exception e) {

        }

    }
}
