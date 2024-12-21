package com.mycompany.newssites;

import com.mongodb.client.*;
import org.bson.Document;

import java.time.*;
import java.time.temporal.WeekFields;
import java.util.*;

public class ClassificationCounter {
    public static List<Map.Entry<String, Integer>> getWeeklyClassifications() {
        List<Map.Entry<String, Integer>> classificationList = new ArrayList<>();
        
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("news");
            MongoCollection<Document> collection = database.getCollection("news_sites");

            LocalDate today = LocalDate.now();
            LocalDate startOfWeek = today.with(WeekFields.of(Locale.getDefault()).dayOfWeek(), 1);
            LocalDate endOfWeek = startOfWeek.plusDays(6);

            long startOfWeekMillis = startOfWeek.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
            long endOfWeekMillis = endOfWeek.atTime(LocalTime.MAX).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();

            Map<String, Integer> classificationCount = new HashMap<>();

            FindIterable<Document> docs = collection.find(
                new Document("publication_date", new Document("$gte", new Date(startOfWeekMillis))
                        .append("$lte", new Date(endOfWeekMillis)))
            );

            for (Document doc : docs) {
                String classification = doc.getString("classification");
                classificationCount.put(classification, classificationCount.getOrDefault(classification, 0) + 1);
            }

            classificationList.addAll(classificationCount.entrySet());
        }

        return classificationList;
    }

    public static List<Map.Entry<String, Integer>> getMonthlyClassifications() {
        List<Map.Entry<String, Integer>> classificationList = new ArrayList<>();
        
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("news");
            MongoCollection<Document> collection = database.getCollection("news_sites");

            LocalDate today = LocalDate.now();
            LocalDate startOfMonth = today.withDayOfMonth(1);
            LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

            long startOfMonthMillis = startOfMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
            long endOfMonthMillis = endOfMonth.atTime(LocalTime.MAX).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();

            Map<String, Integer> classificationCount = new HashMap<>();

            FindIterable<Document> docs = collection.find(
                new Document("publication_date", new Document("$gte", new Date(startOfMonthMillis))
                        .append("$lte", new Date(endOfMonthMillis)))
            );

            for (Document doc : docs) {
                String classification = doc.getString("classification");
                classificationCount.put(classification, classificationCount.getOrDefault(classification, 0) + 1);
            }

            classificationList.addAll(classificationCount.entrySet());
        }

        return classificationList;
    }

    public static List<Map.Entry<String, Integer>> getYearlyClassifications() {
        List<Map.Entry<String, Integer>> classificationList = new ArrayList<>();
        
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("news");
            MongoCollection<Document> collection = database.getCollection("news_sites");

            LocalDate today = LocalDate.now();
            LocalDate startOfYear = today.withDayOfYear(1);
            LocalDate endOfYear = today.withDayOfYear(today.lengthOfYear());

            long startOfYearMillis = startOfYear.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
            long endOfYearMillis = endOfYear.atTime(LocalTime.MAX).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();

            Map<String, Integer> classificationCount = new HashMap<>();

            FindIterable<Document> docs = collection.find(
                new Document("publication_date", new Document("$gte", new Date(startOfYearMillis))
                        .append("$lte", new Date(endOfYearMillis)))
            );

            for (Document doc : docs) {
                String classification = doc.getString("classification");
                classificationCount.put(classification, classificationCount.getOrDefault(classification, 0) + 1);
            }

            classificationList.addAll(classificationCount.entrySet());
        }

        return classificationList;
    }
}
