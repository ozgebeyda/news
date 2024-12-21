package com.mycompany.newssites;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import com.mongodb.client.MongoCursor;
import org.bson.Document;

public class Database {
    private MongoClient mongoClient;
    private MongoDatabase database;
    private MongoCollection<Document> rssCollection;
    private MongoCollection<Document> newsCollection;

    // Veritabanına bağlanma
    public void connect() {
        try {
            mongoClient = MongoClients.create("mongodb://localhost:27017");
            database = mongoClient.getDatabase("news");
            rssCollection = database.getCollection("rss_link");
            newsCollection = database.getCollection("news_sites");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Veritabanından RSS linklerini al
    public MongoCursor<Document> getRssLinks(int siteId) {
        return rssCollection.find(Filters.eq("site_id", siteId)).iterator();
    }

    // Mevcut en büyük ID'yi bul
    public int getCurrentMaxId() {
        Document lastDoc = newsCollection.find().sort(Sorts.descending("id")).first();
        return (lastDoc != null) ? lastDoc.getInteger("id") + 1 : 1;
    }

    // Haberleri veritabanına ekle
    public void insertNews(Document newsDoc) {
        newsCollection.insertOne(newsDoc);
    }

    // İçeriğin veritabanında mevcut olup olmadığını kontrol et
    public boolean isContentExists(String content) {
        Document found = newsCollection.find(Filters.eq("content", content)).first();
        return found != null; // Eğer bulunursa true döner
    }

    // Bağlantıyı kapat
    public void close() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
