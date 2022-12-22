import 'package:flutter/material.dart';
import 'package:apk_api/controllers/log-cont.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logout = LogController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 53, 255),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Halaman Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
             MaterialButton(
              minWidth: 500,
              height: 50,
              child: Text(
                "Logout",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: const Color.fromARGB(255, 26, 53, 255),
              onPressed: () {
                logout.postDataOut().then(
                      (value) =>
                          Navigator.of(context).popAndPushNamed('/login'),
                    );
              },
            ),
          ],
        ),
        ),
      );
  }
}