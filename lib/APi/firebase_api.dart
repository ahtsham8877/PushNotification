import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/main.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _firebaseMessaging.requestPermission();

    String? fcmToken = await _firebaseMessaging.getToken();
    print("PhoneToken is in API: $fcmToken");

    pushInitNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.body}");

      _showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }

  Future<void> _showNotification({String? title, String? body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void handleMsg(RemoteMessage? msg) {
    if (msg == null) {
      print("No message received");
      return;
    }

    print("Navigating to notification screen with payload: ${msg.data}");

    navigatorKey.currentState?.pushNamed('/ShowNotification', arguments: msg);
  }

  Future<void> pushInitNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Initial message: ${message?.data}");
      handleMsg(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Message opened: ${message.data}");
      handleMsg(message);
    });
  }
}
