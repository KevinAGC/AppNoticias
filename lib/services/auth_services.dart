import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'loginpruebakg.somee.com';
  final storage = FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final authData = {'email': email, 'password': password};
    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final authData = {'email': email, 'password': password};
    final url = Uri.http(_baseUrl, '/api/Cuentas/login');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> sendPostRequest(String title, String link) async {
    final String apiUrl = 'http://192.168.1.92:5000/api/Cuentas/Favorito';

    try {
      Map<String, dynamic> postData = {
        "userId": "2",
        "title": title,
        "link": link
      };
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await readToken()}',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        return response.body.toString();
      } else {
        print('Request failed with status: ${response.statusCode}');
        return response.body;
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> sendGetRequest() async {
    final String apiUrl = 'http://192.168.1.92:5000/api/Cuentas/Favorito';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await readToken()}',
        },
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> mapList =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return mapList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<String> sendDeleteRequest(String id) async {
    final String apiUrl = 'http://192.168.1.92:5000/api/Cuentas/Favorito';
    print(Uri.parse('$apiUrl/$id'));
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await readToken()}',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.toString();
      } else {
        return 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred: $e';
    }
  }
}
