import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import '../models/wishItem.dart';

import './login_service.dart';

/*
 * wishlist_service 설명
 * 1. 위시리스트에 아이템을 등록하기
 * List<Item> items가 있다면 그 중 선택된 item에 대해서
 * await addWishlist(item.id.toString(), token);으로 추가할 수 있음.
 * 추가 후에는 getX를 이용해서 위시리스트 페이지를 업데이트(새로고침) 해주시면됨.
 *
 * 2. 위시리스트 조회하기
 * fetch와 get은 같이 써야함. (순서 fetch -> get)
 * Progress : 진행중인 위시리스트
 * Completed : 완료되었지만 사용하지 않은 위시리스트
 * Used : 사용까지 완료한 위시리스트
 * 예시) 진행중인 위시리스트 List<WishItem>로 받아오기
 * await fetchProgressWishItems(token);
 * List<WishItem> progressWishItems = await getProgressWishItems();
 *
 * 아래는 쓸 일이 없겠지만 api 명세서에 있어서 만든 것 / 위시리스트 진행도와 관계없이 다 갖고 오기
 * Future<void> fetchWishItems(String token) async
 * Future<List<WishItem>> getAllWishItems() async
 *
 * save는 로직상 wishlist_service 안에서만 사용하는 함수들.
 * static으로 선언할걸 그랬나.
 */

Future<void> saveWishItemsToLocal(dynamic wishItems) async {
  var box = await Hive.openBox<WishItem>('wishItemBox');

  if(wishItems is List<WishItem>) {
    await box.clear();
    for (var wishItem in wishItems) {
      await box.put(wishItem.wishItemId, wishItem);
    }
  } else if (wishItems is WishItem) {
      await box.put(wishItems.wishItemId, wishItems);
    } else {
    throw ArgumentError('The argument must be a WishItem or List<WishItem>');
  }
  await box.close();
}

Future<List<WishItem>> getAllWishItems() async {
  var box = await Hive.openBox<WishItem>('wishItemBox');
  List<WishItem> wishItems = box.values.toList();
  await box.close();
  return wishItems;
}

Future<void> saveProgressItemsToLocal(dynamic wishItems) async {
  var box = await Hive.openBox<WishItem>('progressWishItemBox');

  if(wishItems is List<WishItem>) {
    await box.clear();
    for (var wishItem in wishItems) {
      await box.put(wishItem.wishItemId, wishItem);
    }
  } else if (wishItems is WishItem) {
    await box.put(wishItems.wishItemId, wishItems);
  } else {
    throw ArgumentError('The argument must be a WishItem or List<WishItem>');
  }
  await box.close();
}

Future<List<WishItem>> getProgressWishItems() async {
  var box = await Hive.openBox<WishItem>('progressWishItemBox');
  List<WishItem> wishItems = box.values.toList();
  await box.close();
  return wishItems;
}

Future<void> saveCompletedItemsToLocal(dynamic wishItems) async {
  var box = await Hive.openBox<WishItem>('completedWishItemBox');

  if(wishItems is List<WishItem>) {
    await box.clear();
    for (var wishItem in wishItems) {
      await box.put(wishItem.wishItemId, wishItem);
    }
  } else if (wishItems is WishItem) {
    await box.put(wishItems.wishItemId, wishItems);
  } else {
    throw ArgumentError('The argument must be a WishItem or List<WishItem>');
  }
  await box.close();
}

Future<List<WishItem>> getCompletedWishItems() async {
  var box = await Hive.openBox<WishItem>('completedWishItemBox');
  List<WishItem> wishItems = box.values.toList();
  await box.close();
  return wishItems;
}

Future<void> saveUsedItemsToLocal(dynamic wishItems) async {
  var box = await Hive.openBox<WishItem>('usedWishItemBox');

  if(wishItems is List<WishItem>) {
    await box.clear();
    for (var wishItem in wishItems) {
      await box.put(wishItem.wishItemId, wishItem);
    }
  } else if (wishItems is WishItem) {
    await box.put(wishItems.wishItemId, wishItems);
  } else {
    throw ArgumentError('The argument must be a WishItem or List<WishItem>');
  }
  await box.close();
}

Future<List<WishItem>> getUsedWishItems() async {
  var box = await Hive.openBox<WishItem>('usedWishItemBox');
  List<WishItem> wishItems = box.values.toList();
  await box.close();
  return wishItems;
}

Future<void> fetchWishItems(String token) async {
  final String memberID = await getID() ?? '0';
  if(memberID == '0') throw Exception('다시 로그인해주세요.');
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/all/$memberID');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      // UTF-8로 디코딩한 후 JSON으로 파싱
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> wishItemJsonList = json.decode(decodedResponse);
      List<WishItem> wishItemList =
        wishItemJsonList.map((jsonItem) => WishItem.fromJson(jsonItem)).toList();
      await saveWishItemsToLocal(wishItemList);
      print('위시 아이템 가져오기 성공: ${wishItemList.length}개의 아이템이 있습니다.');
    } else {
      print('위시 아이템 가져오기 실패: ${response.statusCode}');
    }
  } catch(e) {
    print('오류 발생: $e');
  }
}

Future<void> fetchProgressWishItems(String token) async {
  final String memberID = await getID() ?? '0';
  if(memberID == '0') throw Exception('다시 로그인해주세요.');
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/progress/$memberID');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      // UTF-8로 디코딩한 후 JSON으로 파싱
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> wishItemJsonList = json.decode(decodedResponse);
      List<WishItem> wishItemList =
      wishItemJsonList.map((jsonItem) => WishItem.fromJson(jsonItem)).toList();
      await saveProgressItemsToLocal(wishItemList);
      print('위시 아이템 가져오기 성공: ${wishItemList.length}개의 아이템이 있습니다.');
    } else {
      print('위시 아이템 가져오기 실패: ${response.statusCode}');
    }
  } catch(e) {
    print('오류 발생: $e');
  }
}

Future<void> fetchCompletedWishItems(String token) async {
  final String memberID = await getID() ?? '0';
  if(memberID == '0') throw Exception('다시 로그인해주세요.');
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/completed/$memberID');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      // UTF-8로 디코딩한 후 JSON으로 파싱
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> wishItemJsonList = json.decode(decodedResponse);
      List<WishItem> wishItemList =
      wishItemJsonList.map((jsonItem) => WishItem.fromJson(jsonItem)).toList();
      await saveCompletedItemsToLocal(wishItemList);
      print('위시 아이템 가져오기 성공: ${wishItemList.length}개의 아이템이 있습니다.');
    } else {
      print('위시 아이템 가져오기 실패: ${response.statusCode}');
    }
  } catch(e) {
    print('오류 발생: $e');
  }
}

Future<void> fetchUsedWishItems(String token) async {
  final String memberID = await getID() ?? '0';
  if(memberID == '0') throw Exception('다시 로그인해주세요.');
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/used/$memberID');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      // UTF-8로 디코딩한 후 JSON으로 파싱
      String decodedResponse = utf8.decode(response.bodyBytes);
      List<dynamic> wishItemJsonList = json.decode(decodedResponse);
      List<WishItem> wishItemList =
      wishItemJsonList.map((jsonItem) => WishItem.fromJson(jsonItem)).toList();
      await saveUsedItemsToLocal(wishItemList);
      print('위시 아이템 가져오기 성공: ${wishItemList.length}개의 아이템이 있습니다.');
    } else {
      print('위시 아이템 가져오기 실패: ${response.statusCode}');
    }
  } catch(e) {
    print('오류 발생: $e');
  }
}

Future<void> addWishlist(String itemID, String token) async {
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/add/$itemID');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.post(url, headers: headers);
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