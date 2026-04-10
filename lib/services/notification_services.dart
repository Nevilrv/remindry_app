import 'dart:developer';
import 'dart:math' hide log;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // NotificationServices().displayNotification();
  // If you're going to use other Firebase services in}
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Handling a background message ${message.messageId}');
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationServices {
  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'basic_channel', // id
    'Basic Notifications', // name
    description: 'Notification tests as alerts',
    importance: Importance.high,
    playSound: true,
    showBadge: false,
  );
  Future<void> initlizedNotification() async {
    await FirebaseMessaging.instance.requestPermission();
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // ...
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("📩 received notification");
      log("📩 event ${event}");
      // displayNotification();
      // if (event != null && event.data != null && payload.payload!.isNotEmpty) {
      //   final Map<String, dynamic> data = jsonDecode(payload.payload!);
      // }
    });
    FirebaseMessaging.onMessage.listen((event) {
      displayNotification(eventData: event);
    });
  }

  Future<void> displayNotification({required RemoteMessage eventData}) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(100000),
      eventData.notification?.title,
      eventData.notification?.body,
      notificationDetails,
      // payload: 'item x',
    );
  }

  Future<void> getPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
