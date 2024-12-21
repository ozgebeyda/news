package com.mycompany.newssites;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class NewsFetcher {
    private final String uri = "mongodb://localhost:27017"; 
    private final String databaseName = "news"; 
    private final String collectionName = "news_sites"; 

    // Belirli bir başlığa, yayım tarihine, site adına ve sınıflandırmaya göre haberleri çeken yöntem
    public List<Document> fetchNews(String title, Date publishDate, String siteName, String classification, int page, int pageSize) {
        List<Document> newsList = new ArrayList<>();
        Date startDate = null;
        Date endDate = null;

        if (publishDate != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(publishDate);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            startDate = cal.getTime();
            cal.add(Calendar.DATE, 1);
            endDate = cal.getTime();
        }

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            
            Bson query = Filters.and(
                (title != null && !title.isEmpty()) ? Filters.regex("title", title, "i") : Filters.empty(),
                (publishDate != null) ? Filters.and(Filters.gte("publication_date", startDate), Filters.lt("publication_date", endDate)) : Filters.empty(),
                (siteName != null && !siteName.isEmpty()) ? Filters.eq("site_name", siteName) : Filters.empty(),
                (classification != null && !classification.isEmpty()) ? Filters.eq("classification", classification) : Filters.empty()
            );

            FindIterable<Document> newsIterable = collection.find(query)
                .sort(Sorts.descending("publication_date")) 
                .skip((page - 1) * pageSize)
                .limit(pageSize);

            for (Document doc : newsIterable) {
                newsList.add(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newsList;
    }

    // Belirli filtrelerle toplam haber sayısını döndüren yöntem
    public long getTotalNewsCount(String title, Date publishDate, String siteName, String classification) {
        long count = 0;
        Date startDate = null;
        Date endDate = null;

        if (publishDate != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(publishDate);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            startDate = cal.getTime();
            cal.add(Calendar.DATE, 1);
            endDate = cal.getTime();
        }

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            
            Bson query = Filters.and(
                (title != null && !title.isEmpty()) ? Filters.regex("title", title, "i") : Filters.empty(),
                (publishDate != null) ? Filters.and(Filters.gte("publication_date", startDate), Filters.lt("publication_date", endDate)) : Filters.empty(),
                (siteName != null && !siteName.isEmpty()) ? Filters.eq("site_name", siteName) : Filters.empty(),
                (classification != null && !classification.isEmpty()) ? Filters.eq("classification", classification) : Filters.empty()
            );

            count = collection.countDocuments(query);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // Tüm benzersiz site adlarını döndüren yöntem
    public List<String> fetchUniqueSiteNames() {
        List<String> siteNames = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            
            for (String siteName : collection.distinct("site_name", String.class)) {
                siteNames.add(siteName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return siteNames;
    }
    
    // Tüm benzersiz sınıflandırmaları döndüren yöntem
    public List<String> fetchUniqueClassifications() {
        List<String> classifications = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            
            for (String classification : collection.distinct("classification", String.class)) {
                classifications.add(classification);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return classifications;
    }

    // Belirli bir haberin detaylarını döndüren yöntem
    public Document fetchNewsById(String id) {
        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            return collection.find(Filters.eq("_id", new ObjectId(id))).first();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Benzer haberleri döndüren yöntem (sınıflandırmayı kontrol et)
    public List<Document> fetchSimilarNews(String newsId, String content, String classification) {
        List<Document> similarNews = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            String[] keywords = content.split(" "); // İçerikten kelimeleri al

            // Sadece aynı sınıflandırmaya sahip haberleri kontrol et
            for (String keyword : keywords) {
                FindIterable<Document> result = collection.find(
                    Filters.and(
                        Filters.regex("content", keyword),
                        Filters.eq("classification", classification) // Aynı sınıflandırmaya sahip olma şartı
                    )
                ).limit(5);
                for (Document doc : result) {
                    if (!doc.getObjectId("_id").toHexString().equals(newsId)) {
                        similarNews.add(doc);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return similarNews;
    }

    // Benzer haberleri döndüren yöntem (yalnızca en benzeri)
    public Document fetchMostSimilarNews(String newsId, String content, String classification) {
        Document mostSimilarNews = null;
        List<Document> similarNews = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);
            String[] keywords = content.split(" "); // İçerikten kelimeleri al

            // Sadece aynı sınıflandırmaya sahip haberleri kontrol et
            for (String keyword : keywords) {
                FindIterable<Document> result = collection.find(
                    Filters.and(
                        Filters.regex("content", keyword),
                        Filters.eq("classification", classification) // Aynı sınıflandırmaya sahip olma şartı
                    )
                ).limit(5);
                for (Document doc : result) {
                    if (!doc.getObjectId("_id").toHexString().equals(newsId)) {
                        similarNews.add(doc);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Benzer haberler arasından en ilkini döndür
        if (!similarNews.isEmpty()) {
            mostSimilarNews = similarNews.get(0); // İlk benzer haberi al
        }

        return mostSimilarNews;
    }
}
