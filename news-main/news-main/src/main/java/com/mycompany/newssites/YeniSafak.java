package com.mycompany.newssites;

import com.mongodb.client.MongoCursor;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;


public class YeniSafak 
{

    public static void main(String[] args) 
    {
        YeniSafak Y = new YeniSafak();
        Y.YeniSafakCalis();
    }

     private static final Database database = new Database();

    public void YeniSafakCalis() 
    {
        // Veritabanına bağlan
        database.connect();

        // site_id = 1 olan RSS linklerini al
        MongoCursor<Document> cursor = database.getRssLinks(26);

        // Haberleri işleyip veritabanına ekle
        while (cursor.hasNext()) {
            Document doc = cursor.next();
            String rssLink = doc.getString("link");

            parseAndInsertLinks(rssLink);
        }

        // Veritabanı bağlantısını kapat
        database.close();
    }

private static void parseAndInsertLinks(String rssLink) {
    try {
        org.jsoup.nodes.Document doc = Jsoup.connect(rssLink).get();
        Elements items = doc.select("item");

        String siteLink = doc.selectFirst("channel > link").text();
        String siteName = doc.selectFirst("channel > title").text();
        int currentId = database.getCurrentMaxId();

        for (Element item : items) {
            String title = item.select("title").text();
            String content = item.select("description").text();
            String detailContent = item.getElementsByTag("content:encoded").text();
            String pubDate = item.select("pubDate").text();
            String link = item.select("link").text();
            
            // <image> etiketinden fotoğraf URL'sini al
            String photograph = item.selectFirst("image > url") != null
                    ? item.selectFirst("image > url").text()
                    : null;

            String currentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            // Dil tespiti ve kelime işlemleri artık CommonUtils'ten çağrılıyor
            String detectedLanguage = CommonUtils.detectLanguage(content);
            String cleanData = CommonUtils.removeInfrequentWords(content);
            cleanData = cleanData.isEmpty() ? content : cleanData;
            String classification = Classification.classifyContent(cleanData); // Updated line

            Document newsDoc = new Document("id", currentId)
                    .append("rss_link", rssLink)
                    .append("site_name", siteName)
                    .append("site_link", siteLink)
                    .append("link", link)
                    .append("title", title)
                    .append("content", content)
                    .append("detail_content", detailContent)
                    .append("publication_date", pubDate)
                    .append("record_date", currentDate)
                    .append("photograph", photograph)  // Updated line
                    .append("language", detectedLanguage)
                    .append("clear_data", cleanData)
                    .append("classification", classification);
            database.insertNews(newsDoc);
            currentId++;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
