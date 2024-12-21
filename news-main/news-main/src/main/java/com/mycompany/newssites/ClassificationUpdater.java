package com.mycompany.newssites;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Accumulators;
import org.bson.Document;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ClassificationUpdater {
    public List<Document> getClassificationCounts() {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("news");
        MongoCollection<Document> collection = database.getCollection("news_sites");

        // Sınıflandırmalara göre sayıları gruplama
        List<Document> counts = collection.aggregate(Arrays.asList(
                Aggregates.group("$classification", Accumulators.sum("count", 1))
        )).into(new ArrayList<>());

        mongoClient.close();
        return counts; // Sınıflandırma sayımlarını döndür
    }
}
