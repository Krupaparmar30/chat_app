import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  LocalNotificationServices._();

  static LocalNotificationServices notificationServices =
      LocalNotificationServices._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  //init
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails("chat", "Local Notifiction",
          importance: Importance.max, priority: Priority.max);

  Future<void> initNotificationServices() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("mipmap/ic_launcher");

    DarwinInitializationSettings darwinSettingsIos =
        const DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
        android: androidSettings, iOS: darwinSettingsIos);

    await plugin.initialize(settings);
  }

  // show

  Future<void> showNotificationServices(String title, String body) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await plugin.show(0, title, body, notificationDetails);
  }

  Future<void> scheduledNotification()
  async {
    tz.Location location = tz.getLocation("Asia/Kolkata");
    await plugin.zonedSchedule(
      1,
      "Big Diwali Offer",
      "All Product 25% Off !!!!!!!",
      tz.TZDateTime.now(location).add(const Duration(seconds: 5)),
      NotificationDetails(android: androidNotificationDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );



  }
}
