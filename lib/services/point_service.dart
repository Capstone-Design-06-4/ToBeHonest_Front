import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import '../models/wishItem.dart';
import 'package:tobehonest/services/url_manager.dart';

import './login_service.dart';

Future<http.Response> addPoint(WishItem wishItem, int fundAmount,
    int friendID, String token) async {
  final url = Uri.parse('${UrlManager.baseUrl}contribution/${wishItem.wishItemId}/$fundAmount');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  //final body = json.encode({
  //  'fundAmount': fundAmount,
  //});

  try {
    //final response = await http.post(url, headers: headers, body: body);
    final response = await http.post(url, headers: headers);

    if(response.statusCode == 200) print('메세지가 성공적으로 전송되었습니다.');
    return response; // HTTP 응답 반환
  } catch (e) {
    print('오류 발생: $e');
    rethrow; // 예외를 다시 발생시켜 호출자에게 전달
  }
}