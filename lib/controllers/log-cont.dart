import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class LogController {
  final _baseURL = 'http://192.168.1.15:8000/api/';

  final storage = new FlutterSecureStorage();

  Future postData(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseURL + 'auth/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
          'device_name': 'android',
        },
      );

      if (response.statusCode == 200) {
        print('token : ' + response.body);

        await storage.write(
          key: 'token',
          value: jsonDecode(response.body)['token'],
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

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

  Future postRegister(String name, String email, String password,
      String confirm_password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseURL + 'auth/register'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirm_password,
          'device_name': 'android',
        },
      );

      if (response.statusCode == 200) {
        print('token : ' + response.body);

        await storage.write(
          key: 'token',
          value: jsonDecode(response.body)['token'],
        );
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
