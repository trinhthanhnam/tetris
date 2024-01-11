import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tetris_match/api/firebase_api.dart';
import 'package:tetris_match/firebase_options.dart';
import 'package:tetris_match/page/homepage.dart';
import 'package:tetris_match/page/notification_page.dart';
import 'package:tetris_match/tetris/board.dart';

final navigationHomepage = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      navigatorKey: navigationHomepage,
      routes: {
        '/notification': (context) => NotificationPage(),
        '/game': (context) => Board(),
      },
    );
  }
}

