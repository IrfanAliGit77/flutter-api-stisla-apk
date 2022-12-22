import 'package:flutter/material.dart';
import 'package:apk_api/controllers/login-cont.dart';
import 'package:apk_api/screens/home/home-view.dart';
import 'package:apk_api/screens/login/login-view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      routes: {
        '/login': (context) => MainApp(),
        '/homepage': (context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}