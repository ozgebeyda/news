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

public class Tobb {

    public static void main(String[] args) {
        Tobb t = new Tobb();
        t.TakvimCalis();
    }

    private static final Database database = new Database();

    public void TakvimCalis() {
        // Veritabanına bağlan
        database.connect();

        // site_id = 1 olan RSS linklerini al
        MongoCursor<Document> cursor = database.getRssLinks(22);

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
                String link = item.select("link").text();
                String photograph = item.selectFirst("img") != null
                        ? item.selectFirst("enclosure[type=image/jpeg]").attr("url")
                        : null;

                // Haber detay sayfasındaki div içeriğini almak için
                String articleBody = fetchArticleBody(link);

                // Tarihlerin Date formatına dönüştürülmesi
                String pubDateStr = item.select("pubDate").text();
                Date pubDate = CommonUtils.parseDate(pubDateStr); // pubDate artık Date formatında

                Date currentDate = new Date();  // Şu anki tarih

                // Dil tespiti ve kelime işlemleri artık CommonUtils'ten çağrılıyor
                String detectedLanguage = CommonUtils.detectLanguage(content);
                String cleanData = CommonUtils.removeInfrequentWords(content);
                cleanData = cleanData.isEmpty() ? content : cleanData;
                String classification = Classification.classifyContent(cleanData);

                // Aynı content içeren bir haber olup olmadığını kontrol et
                if (!database.isContentExists(content)) {
                    Document newsDoc = new Document("id", currentId)
                            .append("rss_link", rssLink)
                            .append("site_name", siteName)
                            .append("site_link", siteLink)
                            .append("link", link)
                            .append("title", title)
                            .append("content", content)
                            .append("detail_content", detailContent)
                            .append("news_detail", articleBody) // Detay sayfasındaki div içerikleri burada ekleniyor
                            .append("publication_date", pubDate) // Date formatında pubDate
                            .append("record_date", currentDate) // Date formatında currentDate
                            .append("photograph", photograph)
                            .append("language", detectedLanguage)
                            .append("clear_data", cleanData)
                            .append("classification", classification);
                    database.insertNews(newsDoc);
                    currentId++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Detay sayfasına gidip belirli <div> elementinden içeriği almak
    private static String fetchArticleBody(String detailLink) {
        try {
            org.jsoup.nodes.Document detailDoc = Jsoup.connect(detailLink).get();

            // Belirli div elementini seçiyoruz
            Element leftColumnDiv = detailDoc.selectFirst("div#left-column");

            if (leftColumnDiv != null) {
                return leftColumnDiv.outerHtml();  // Div'in dış HTML içeriğini al
            } else {
                return ""; // Eğer div bulunamazsa boş string döner
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Hata durumunda boş string döner
        }
    }
}
