//login_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tobehonest/services/url_manager.dart';


Future<void> saveID(String ID) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('ID', ID);
}

Future<String?> getID() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('ID');
}

Future<void> saveProfileImg(String ProfileImg) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('ProfileImg', ProfileImg);
}

Future<String?> getProfileImg() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('ProfileImg');
}

Future<void> saveEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

Future<String?> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

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
  var url = Uri.parse('${UrlManager.baseUrl}signup');
  var response = await http.post(url, body: json.encode(user), headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    print('Request to ${url.path} succeeded: ${response.body}');
  } else {
    print('Request to ${url.path} failed with status ${response.statusCode}: ${response.body}');
  }
}

Future<void> login(String email, String password) async {
  final url = Uri.parse('${UrlManager.baseUrl}login');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'email': email, 'password': password});

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['accessToken'];
      //print('Token before saved: ' + accessToken);
      await saveToken(accessToken);
      await saveEmail(email);
      await getMyInfoFirst(email, accessToken);
      print('로그인 성공: ${response.statusCode}');
      //print('Token saved: ' + accessToken);
    } else {
      print('로그인 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}

Future<void> getMyInfoFirst(String email, String token) async {
  final String url = '${UrlManager.baseUrl}members/search/email/$email';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );

  if(response.statusCode == 200) {
    var friendData = json.decode(response.body);
    int memberId = friendData['memberId'] ?? '0';
    String memberName = friendData['memberName'] ?? 'Unknown';
    String profileURL = friendData['profileImgURL'] ?? 'default.png';
    String friendStatus = friendData['friendStatus'];

    if(memberId == 0 || friendStatus != "ME") {
      print('ID 갖고 오기 실패');
      throw Exception;
    }
    await saveID(memberId.toString());
    await saveProfileImg(profileURL);
  } else {
    throw Exception;
  }
}