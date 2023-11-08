import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/friend.dart';

// Hive 초기화 및 어댑터 등록
void setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FriendAdapter()); // FriendAdapter는 Friend 클래스를 Hive에 저장하기 위한 어댑터입니다.
}

Future<void> fetchFriends(String accessToken) async {
  final url = Uri.parse('http://10.0.2.2:8080/members/friends');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $accessToken",
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // JSON 응답을 파싱하여 Friend 객체 리스트로 변환
      List<dynamic> friendJsonList = json.decode(response.body);
      List<Friend> friendsList = friendJsonList.map((jsonItem) => Friend.fromJson(jsonItem)).toList();


      // 친구 목록을 로컬 저장소에 저장
      await saveFriendsToLocal(friendsList);

      print('친구 목록 가져오기 성공: ${friendsList.length}명의 친구가 있습니다.');
    } else {
      print('친구 목록 가져오기 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}

Future<void> saveFriendsToLocal(List<Friend> friendsList) async {
  var box = await Hive.openBox<Friend>('friendsBox');

  // 기존의 친구 목록을 지우고 새 목록으로 대체
  await box.clear();
  //await box.addAll(friendsList);
  // List를 순회하면서 각 Friend 객체를 id를 키로 사용하여 저장
  for (var friend in friendsList) {
    await box.put(friend.id, friend);
  }
}

Future<List<Friend>> getAllFriends() async {
  var box = await Hive.openBox<Friend>('friendsBox');
  List<Friend> friends = box.values.toList();
  await box.close();
  return friends;
}