import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ShowNotification extends StatelessWidget {
  const ShowNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    print("Title is ${message.notification?.title}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Notification"),
      ),
      body: Column(
        children: [
          Text("Title: ${message.notification?.title}"),
          Text("Body: ${message.notification?.body}"),
          Text("Data: ${message.data.toString()}"),
        ],
      ),
    );
  }
}
