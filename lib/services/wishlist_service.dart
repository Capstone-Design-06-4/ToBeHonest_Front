import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import './login_service.dart';

Future<void> fetchWishlist(String token) async {
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/all/');
}

Future<void> addWishlist(String itemID, String token) async {
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/add/$itemID');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      print('위시리스트에 정상적으로 등록되었습니다.');
    } else {
      print('위시리스트 등록에 실패했습니다.');
    }
  }
  catch(e) {
    throw Exception('오류 발생: $e');
  }
}