package com.mycompany.newssites;

import com.mongodb.client.MongoCursor;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;

import java.util.Date;

public class CnnTurk {

    public static void main(String[] args) {
        CnnTurk c = new CnnTurk();
        c.CnnTurkCalis();
    }

    private static final Database database = new Database();

    public void CnnTurkCalis() {
        // Veritabanına bağlan
        database.connect();

        // site_id = 1 olan RSS linklerini al
        MongoCursor<Document> cursor = database.getRssLinks(2);

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
                String photograph = item.selectFirst("enclosure[type=image/jpeg]") != null
                        ? item.selectFirst("enclosure[type=image/jpeg]").attr("url")
                        : "https://www.haber7.com/sondakika";

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

public static String fetchArticleBody(String url) {
        try {
            // Jsoup ile sayfayı çekiyoruz
            org.jsoup.nodes.Document doc = Jsoup.connect(url).get();
            
            // Makale gövdesini seçme işlemi (örnek CSS seçici, sayfa yapısına göre değiştirin)
            Element bodyElement = doc.selectFirst("div.card-spot");  // div.card-spot elementini seç
            if (bodyElement != null) {
                return bodyElement.text();  // Makale gövdesinin metnini döndür
            } else {
                return "Detaylara Haber Sitesinden Ulaşınız."; // Eğer div bulunamazsa boş string döner
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Hata durumunda boş string döner
        }
    }
}
