import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import './login_service.dart';
import 'package:tobehonest/services/url_manager.dart';


/*
 * wishlist_service 설명
 * 1. 아이템 찾기(키워드로 찾기, 카테고리로 찾기)
 * textField에서 받은 String searchQuery에 대해서
 * List<Item> items = await findItemByKeyword(searchQuery, token);
 * List<Item> items = await findItemByCategory(searchQuery, token);
 *
 * get이랑 save는 쓸 일 없을듯.
 */

Future<void> saveItemResultToLocal(dynamic items) async {
  var box = await Hive.openBox<Item>('itemsBox');
  await box.clear();
  if(items is List<Item>) {
    for(var item in items) {
      await box.put(item.id, item);
    }
  } else if (items is Item) {
    await box.put(items.id, items);
  } else {
    throw ArgumentError('The argument must be a Friend or List<Item>');
  }
}

Future<List<Item>> getAllItems() async {
  var box = await Hive.openBox<Item>('itemsBox');
  List<Item> items = box.values.toList();
  await box.close();
  return items;
}

Future<List<Item>> findItemByKeyword(String keyword, String accessToken) async {
  final url = Uri.parse('${UrlManager.baseUrl}items/search/$keyword');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $accessToken",
  };
  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // UTF-8로 디코딩한 후 JSON으로 파싱
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> itemJson = json.decode(decodedResponse);
      List<Item> itemsList = itemJson.map((jsonItem) => Item.fromJson(jsonItem))
          .toList();

      await saveItemResultToLocal(itemsList);

      return itemsList;

    } else {
      print('keyword로 검색한 결과가 없습니다.');
      return [];
    }
  } catch (e) {
    throw Exception('오류 발생: $e');
  }
}

Future<List<Item>> findItemByCategory(String category, String accessToken) async {
  final url = Uri.parse('${UrlManager.baseUrl}items/categories/search/$category');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $accessToken",
  };
  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> itemJson = json.decode(decodedResponse);
      List<Item> itemsList = itemJson.map((jsonItem) => Item.fromJson(jsonItem))
          .toList();

      await saveItemResultToLocal(itemsList);

      return itemsList;

    } else {
      print('keyword로 검색한 결과가 없습니다.');
      return [];
    }
  } catch (e) {
    throw Exception('오류 발생: $e');
  }
}