import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import './login_service.dart';

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
  final url = Uri.parse('http://10.0.2.2:8080/items/search/$keyword');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $accessToken",
  };
  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> itemJson = json.decode(response.body);
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
  final url = Uri.parse('http://10.0.2.2:8080/items/search/$category');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $accessToken",
  };
  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> itemJson = json.decode(response.body);
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