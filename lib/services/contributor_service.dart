import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import '../models/item.dart';
import '../models/wishItem.dart';
import '../models/contributor.dart';

import './login_service.dart';
import './friend_service.dart';

/*
 * await fetchContributorByWishItemID(1, token);
 * List<Contributor> contributors = await getAllContributors();
 *
 */

Future<void> saveContributorToLocal(List<Contributor> contributors) async {
  var box = await Hive.openBox<Contributor>('contributorsBox');
  await box.clear();
  for(var contributor in contributors) {
    await box.put(contributor.friendID, contributor);
  }
  await box.close();
}

Future<List<Contributor>> getAllContributors() async {
  var box = await Hive.openBox<Contributor>('contributorsBox');
  List<Contributor> contributors = box.values.toList();
  await box.close();
  return contributors;
}

Future<void> fetchContributorByWishItemID(int wishItemID, String token) async {
  String memberID = await getID() ?? '0';
  if(memberID == '0') throw Exception('다시 로그인해주세요.');
  final url = Uri.parse('http://10.0.2.2:8080/wishlist/details/$memberID/$wishItemID');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      Map<String, dynamic> parsedJson = json.decode(decodedResponse);
      List<dynamic> contributorsJson = parsedJson['contributor'];
      //for(var cj in contributorsJson) cj['friendName'] = getFriendsByID(cj['friendID'] as int);
      List<Contributor> contributors = contributorsJson.map((json) => Contributor.fromJson(json)).toList();
      await saveContributorToLocal(contributors);
    } else {
      print('오류 발생');
    }
  } catch(e) {
    throw Exception('오류 발생: $e');
  }

}