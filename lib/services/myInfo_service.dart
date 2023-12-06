import 'package:tobehonest/models/myInfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:tobehonest/services/url_manager.dart';


Future<MyInfo> getMyInfo(String token) async {
  final url = Uri.parse('${UrlManager.baseUrl}members/detail-information');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      Map<String, dynamic> json = jsonDecode(decodedResponse);
      return MyInfo.fromJson(json); // JSON 응답을 MyInfo 객체로 변환
    } else {
      print('정보 가져오기 실패: ${response.statusCode}');
      throw Exception('정보를 가져오는데 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('오류 발생: $e');
  }
}