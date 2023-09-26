import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  Future<void> initialization() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null && message.notification != null) {
        print('${message.notification!.title} - ${message.notification!.body}');

        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const DarwinInitializationSettings initializationSettingsDarwin =
            DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

        const InitializationSettings initializationSettings =
            InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

        await flutterLocalNotificationsPlugin
            .initialize(initializationSettings);

        const AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails('code23_note_app', 'Code23 Note App',
                channelDescription: 'Code23 Note App Channel',
                importance: Importance.max,
                priority: Priority.high);

        const NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
        );
      }
    });
  }
}
