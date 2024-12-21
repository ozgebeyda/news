package com.mycompany.newssites;

import com.github.pemistahl.lingua.api.Language;
import com.github.pemistahl.lingua.api.LanguageDetector;
import com.github.pemistahl.lingua.api.LanguageDetectorBuilder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class CommonUtils {

    private static final LanguageDetector DETECTOR = LanguageDetectorBuilder.fromAllSpokenLanguages().build();

    // Dil tespiti
    public static String detectLanguage(String content) {
        Language detectedLanguage = DETECTOR.detectLanguageOf(content);
        return detectedLanguage.toString();
    }

    // Metindeki kelimelerin frekansını hesapla
    private static Map<String, Integer> calculateWordFrequencies(String input) {
        String[] words = input.toLowerCase().split("\\s+");
        Map<String, Integer> wordFrequencies = new HashMap<>();

        for (String word : words) {
            wordFrequencies.put(word, wordFrequencies.getOrDefault(word, 0) + 1);
        }

        return wordFrequencies;
    }

    // Gereksiz kelimeleri kaldır
    public static String removeInfrequentWords(String input) {
        Map<String, Integer> wordFrequencies = calculateWordFrequencies(input);
        StringBuilder result = new StringBuilder();

        // Ortalama frekansı hesapla
        double averageFrequency = wordFrequencies.values().stream().mapToInt(Integer::intValue).average().orElse(0);

        // Minimum kelime uzunluğu belirle (örneğin, 3 harf)
        int minLength = 3;

        for (Map.Entry<String, Integer> entry : wordFrequencies.entrySet()) {
            String word = entry.getKey();
            int frequency = entry.getValue();

            // Sıklığı ortalama frekanstan büyük ve minimum kelime uzunluğuna sahip kelimeleri ekle
            if (frequency >= averageFrequency && word.length() >= minLength) {
                result.append(word).append(" ");
            }
        }

        return result.toString().trim();
    }

    // Çoklu formatlı tarih parser
    public static Date parseDate(String dateStr) {
        List<String> dateFormats = Arrays.asList(
                "EEE, dd MMM yyyy HH:mm:ss Z", // Örnek: Fri, 27 Sep 2024 11:02:00 +0300
                "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", // Örnek: 2024-09-27T11:02:00.000+03:00
                "yyyy-MM-dd'T'HH:mm:ssXXX", // Örnek: 2024-09-27T11:02:00+03:00
                "yyyy-MM-dd HH:mm:ss", // Örnek: 2024-09-27 11:02:00
                "yyyy-MM-dd", // Örnek: 2024-09-27
                "dd-MM-yyyy", // Örnek: 27-09-2024
                "MM/dd/yyyy", // Örnek: 09/27/2024
                "EEE MMM dd HH:mm:ss zzz yyyy", // Örnek: Mon Sep 23 19:06:00 TRT 2024
                "EEE, d MMM yyyy HH:mm:ss Z", // Örnek: Wed, 23 Oct 2024 08:52:39 +0000
                "EEE, d MMM yyyy HH:mm:ss z" // Örnek: Fri, 27 Sep 2024 11:02:00 PDT
        );

        for (String format : dateFormats) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat(format, Locale.ENGLISH);
                return dateFormat.parse(dateStr);
            } catch (ParseException e) {
                // Parse hatası olursa bir sonraki formata geçiyoruz
                continue;
            }
        }

        // Hiçbir formatla eşleşmezse o anki tarihi döndür
        System.out.println("Desteklenmeyen tarih formatı: " + dateStr);
        return new Date(); // O anki tarih ve saat döner
    }
}
