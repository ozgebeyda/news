package com.mycompany.newssites;

import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.List;
import java.util.ArrayList;

public class Project 
{

    public static void main(String[] args) 
    {
        Project e = new Project();
        e.ProjectCalis();
    }

    public void ProjectCalis() 
    {
        // Zamanlayıcı oluştur
        Timer timer = new Timer();

        // Saat başı görevler
        scheduleDailyTasks(timer);
        scheduleWeeklyTasks(timer);

        while (true) {
            try {
                Thread.sleep(1000 * 60); // Her dakika kontrol et
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    private static void scheduleDailyTasks(Timer timer) {
        scheduleTask(timer, 0, 0);
        scheduleTask(timer, 2, 0);
        scheduleTask(timer, 4, 0);
        scheduleTask(timer, 6, 0);
        scheduleTask(timer, 8, 0);
        scheduleTask(timer, 10, 0);
        scheduleTask(timer, 12, 0);        
        scheduleTask(timer, 14, 0);
        scheduleTask(timer, 16, 0);
        scheduleTask(timer, 18, 0);
        scheduleTask(timer, 20, 0);
        scheduleTask(timer, 22, 01);
    }

    private static void scheduleWeeklyTasks(Timer timer) {
        TimerTask weeklyTask = new TimerTask() {
            @Override
            public void run() {
                runClassification();
            }
        };

        // Pazar günü her saat başı çalışacak şekilde ayarlama
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);

        long delay = calendar.getTimeInMillis() - System.currentTimeMillis();
        if (delay < 0) {
            delay += 1000 * 60 * 60 * 24 * 7; // Bir hafta ekle
        }

        timer.scheduleAtFixedRate(weeklyTask, delay, 7 * 24 * 60 * 60 * 1000); // Haftalık periyot
    }

    private static void scheduleTask(Timer timer, int hour, int minute) {
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                startThreads();
            }
        };

        // Belirtilen saatte çalışacak zamanlamayı ayarla
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, hour);
        calendar.set(Calendar.MINUTE, minute);
        calendar.set(Calendar.SECOND, 0);
        long delay = calendar.getTimeInMillis() - System.currentTimeMillis();

        // Eğer belirtilen zaman geçmişse, bir gün ekle
        if (delay < 0) {
            delay += 1000 * 60 * 60 * 24;
        }

        timer.scheduleAtFixedRate(task, delay, 24 * 1000 * 60 * 60); // 24 saatlik periyot
    }

    private static void startThreads() {
        // Thread havuzu oluştur
        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(4);

        // Görev listesini oluştur
        List<Runnable> tasks = new ArrayList<>();
        tasks.add(() -> runWithStatus("AnadoluEkspres", AnadoluEkspres.class));
        tasks.add(() -> runWithStatus("CnnTurk", CnnTurk.class));
        tasks.add(() -> runWithStatus("Cumhuriyet", Cumhuriyet.class));
        tasks.add(() -> runWithStatus("Denizli24Haber", Denizli24Haber.class));
        tasks.add(() -> runWithStatus("EnSonHaber", EnSonHaber.class));
        tasks.add(() -> runWithStatus("Gzt", Gzt.class));
        tasks.add(() -> runWithStatus("Haberis", Haberis.class));
        tasks.add(() -> runWithStatus("Haberturk", Haberturk.class));
        tasks.add(() -> runWithStatus("Hurriyet", Hurriyet.class));
        tasks.add(() -> runWithStatus("KayseridenHaberler", KayseridenHaberler.class));
        tasks.add(() -> runWithStatus("Milliyet", Milliyet.class));
        tasks.add(() -> runWithStatus("Mynet", Mynet.class));
        tasks.add(() -> runWithStatus("Ntv", Ntv.class));
        tasks.add(() -> runWithStatus("ReelSektor", ReelSektor.class));
        tasks.add(() -> runWithStatus("RizeTvHaber", RizeTvHaber.class));
        tasks.add(() -> runWithStatus("Sabah", Sabah.class));
        tasks.add(() -> runWithStatus("SamsundanHaberler", SamsundanHaberler.class));
        tasks.add(() -> runWithStatus("SonDakika48", SonDakika48.class));
        tasks.add(() -> runWithStatus("Sozcu", Sozcu.class));
        tasks.add(() -> runWithStatus("Star", Star.class));
        tasks.add(() -> runWithStatus("Takvim", Takvim.class));
        tasks.add(() -> runWithStatus("Tobb", Tobb.class));
        tasks.add(() -> runWithStatus("TrtHaber", TrtHaber.class));
        tasks.add(() -> runWithStatus("YeniAkit", YeniAkit.class));
        tasks.add(() -> runWithStatus("YeniMeaj", YeniMeaj.class));
        tasks.add(() -> runWithStatus("YeniSafak", YeniSafak.class));

        // Görevleri thread havuzuna ekle
        for (Runnable task : tasks) {
            executor.execute(task);
        }

        // Thread havuzunu kapat
        executor.shutdown();
        try {
            executor.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Tüm görevler tamamlandı.");
    }

    private static void runWithStatus(String name, Class<?> clazz) {
        try {
            System.out.println(name + " calistiriliyor");
            clazz.getMethod("main", String[].class).invoke(null, (Object) new String[]{});
            System.out.println(name + " calisti");
        } catch (Exception e) {
            System.err.println(name + " calısırken hata oluştu: " + e.getMessage());
        }
        System.out.println();
    }

    private static void runClassification() {
        try {
            System.out.println("Classification calistiriliyor");
            Class.forName("com.mycompany.project.Classification").getMethod("main", String[].class).invoke(null, (Object) new String[]{});
            System.out.println("Classification calisti");
        } catch (Exception e) {
            System.err.println("Classification calısırken hata oluştu: " + e.getMessage());
        }
        System.out.println();
    }
}
