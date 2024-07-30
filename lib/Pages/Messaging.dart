import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            String? fcmToken = await FirebaseMessaging.instance.getToken();
            print("PhoneToken is: $fcmToken");
          },
          child: const Text("Get Token"),
        ),
      ),
    );
  }
}
