package com.mycompany.newssites;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import org.bson.Document;
import java.util.ArrayList;
import java.util.List;


public class MongoDBHelper {
    public List<Document> getQuestions() {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017"); // Bağlantı adresinizi buraya yazın
        MongoDatabase database = mongoClient.getDatabase("news"); // Veritabanı ismi
        MongoCollection<Document> collection = database.getCollection("questions");

        List<Document> questionsList = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find().iterator()) {
            while (cursor.hasNext()) {
                questionsList.add(cursor.next());
            }
        }
        mongoClient.close();
        return questionsList;
    }
}
