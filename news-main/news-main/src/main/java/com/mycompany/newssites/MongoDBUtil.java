package com.mycompany.newssites;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.FindIterable;
import org.bson.Document;
import java.util.ArrayList;
import java.util.List;

public class MongoDBUtil {

    private final MongoCollection<Document> collection;

    MongoClient mongoClient;
    String connectionString = "mongodb://localhost:27017";
    String dbName = "news";
    String collectionName = "news_sites";

    public MongoDBUtil() {

        mongoClient = MongoClients.create(connectionString);
        MongoDatabase database = mongoClient.getDatabase(dbName);
        collection = database.getCollection(collectionName);

    }

    public void connect() {
        mongoClient = MongoClients.create(connectionString);

    }

    // Haberleri limit ve offset ile getiren metod
    public List<Document> getAllNews(String searchTitle, String publishDate, String siteName, String topic, int limit, int offset) {

        this.connect();

        List<Document> newsList = new ArrayList<>();
        Document filter = new Document();

        // Filtreleme işlemleri
        if (searchTitle != null && !searchTitle.isEmpty()) {
            filter.append("title", new Document("$regex", searchTitle).append("$options", "i")); // Başlıkta arama
        }
        if (publishDate != null && !publishDate.isEmpty()) {
            filter.append("publication_date", publishDate); // Yayın tarihi
        }
        if (siteName != null && !siteName.isEmpty()) {
            filter.append("site_name", siteName); // Site adı
        }
        if (topic != null && !topic.isEmpty()) {
            filter.append("classification", topic); // Konu
        }

        // Belirli limit ve offset ile haberleri getir ve sıralama ekle
        FindIterable<Document> documents = collection.find(filter)
                .sort(new Document("id", -1)) // Azalan sırada sıralama (en büyük id)
                .skip(offset)
                .limit(limit);

        for (Document news : documents) {
            newsList.add(news);
        }

        mongoClient.close();

        return newsList;
    }

    // Toplam haber sayısını getiren metot
    public long getNewsCount(String searchTitle, String publishDate, String siteName, String topic) {

        this.connect();

        Document filter = new Document();

        // Filtreleme işlemleri
        if (searchTitle != null && !searchTitle.isEmpty()) {
            filter.append("title", new Document("$regex", searchTitle).append("$options", "i")); // Başlıkta arama
        }
        if (publishDate != null && !publishDate.isEmpty()) {
            filter.append("publication_date", publishDate); // Yayın tarihi
        }
        if (siteName != null && !siteName.isEmpty()) {
            filter.append("site_name", siteName); // Site adı
        }
        if (topic != null && !topic.isEmpty()) {
            filter.append("classification", topic); // Konu
        }
        mongoClient.close();

        return collection.countDocuments(filter); // Filtreye göre toplam belge sayısını döndür
    }

}
