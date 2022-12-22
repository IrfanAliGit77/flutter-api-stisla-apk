import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

class LogoutController {
  final _baseURL = 'http://192.168.1.15:8000/api/';

  final storage = const FlutterSecureStorage();

  Future postDataOut() async {
    String? value = await storage.read(key: 'token');
    try {
      final response = await http.post(
        Uri.parse('${_baseURL}auth/logout'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $value'},
      );
      await storage.delete(key: 'token');
    } catch (e) {
      print(e.toString());
    }
  }
}
