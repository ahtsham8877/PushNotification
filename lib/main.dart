import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/APi/firebase_api.dart';
import 'package:push_notification/Pages/ShowNotificartion.dart';
import 'package:push_notification/Pages/Messaging.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const MessagingPage(),
        '/ShowNotification': (context) => const ShowNotification(),
      },
    );
  }
}
