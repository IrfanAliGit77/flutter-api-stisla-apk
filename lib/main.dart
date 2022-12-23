import 'package:flutter/material.dart';
import 'package:apk_api/controllers/log-cont.dart';
import 'package:apk_api/screens/home/home-view.dart';
import 'package:apk_api/screens/login/login-view.dart';
import 'package:apk_api/screens/register/register-view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const MainApp(),
        '/homepage': (context) => const HomePage(),
        '/register': (context) => const Register(),

      },
      home: LoginPage(),
    );
  }
}