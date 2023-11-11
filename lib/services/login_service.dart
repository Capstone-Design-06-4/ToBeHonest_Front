//login_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
}

Future<void> signup(Map<String, dynamic> user) async {
  var url = Uri.parse('http://10.0.2.2:8080/signup');
  var response = await http.post(url, body: json.encode(user), headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    print('Request to ${url.path} succeeded: ${response.body}');
  } else {
    print('Request to ${url.path} failed with status ${response.statusCode}: ${response.body}');
  }
}

Future<void> login(String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:8080/login');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'email': email, 'password': password});

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['accessToken'];
      //print('Token before saved: ' + accessToken);
      await saveToken(accessToken);
      print('로그인 성공: ${response.statusCode}');
      //print('Token saved: ' + accessToken);
    } else {
      print('로그인 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}