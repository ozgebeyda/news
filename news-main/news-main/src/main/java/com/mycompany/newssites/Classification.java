package com.mycompany.newssites;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class Classification {

    // İçeriği sınıflandır
    public static String classifyContent(String content) {
        try {
            URL url = new URL("https://api.uclassify.com/v1/ahmetostim/project/classify/");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Token SjoeSG5kP99R");

            JSONObject json = new JSONObject();
            json.put("texts", new String[]{content});

            try (OutputStream os = conn.getOutputStream()) {
                os.write(json.toString().getBytes());
                os.flush();
            }

            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                String output;
                while ((output = br.readLine()) != null) {
                    response.append(output);
                }
            }

            JSONArray jsonResponse = new JSONArray(response.toString());
            if (jsonResponse.length() > 0) {
                JSONObject classification = jsonResponse.getJSONObject(0);
                if (classification.has("classification")) {
                    JSONArray classes = classification.getJSONArray("classification");
                    if (classes.length() > 0) {
                        String subject = "";
                        double maxP = 0;
                        for (int i = 0; i < classes.length(); i++) {
                            JSONObject clazz = classes.getJSONObject(i);
                            double p = clazz.getDouble("p");
                            if (p > maxP) {
                                maxP = p;
                                subject = clazz.getString("className");
                            }
                        }
                        return subject;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "unknown";
    }
}
