import 'package:apk_api/models/kategori.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class kategoriController{
  final _baseURL = 'http://192.168.1.15:8000/api/';

  final storage = const FlutterSecureStorage();

  Future<List<Kategori>> getCategories() async {
    String? value = await storage.read(key: 'token');
    print('value ==> $value');
    if (value == null) {
      throw Exception('ERROR VALUE NULL');
    }
    final response = await http.get(
      Uri.parse('${_baseURL}kategori'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $value',
      },
    );

    final payload = (jsonDecode(response.body)['data'] as List);

    return payload.map((e) => Kategori.fromJson(e)).toList();
  }

  Future addCategories(String name) async {
    String? token = await storage.read(key: 'token');
    try {
      final response = await http.post(
        Uri.parse(_baseURL + 'category'),
        headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: {
          'name': name,
        },
      );
      if (response.statusCode == 201) {
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