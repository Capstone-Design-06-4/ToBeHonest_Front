import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../models/friend.dart';
import './login_service.dart';

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

Future<void> saveFriendsToLocal(dynamic friends) async {
  var box = await Hive.openBox<Friend>('friendsBox');

  // 기존의 친구 목록을 지우고 새 목록으로 대체
  await box.clear();
  if (friends is List<Friend>) {
    // List를 순회하면서 각 Friend 객체를 id를 키로 사용하여 저장
    for (var friend in friends) {
      await box.put(friend.id, friend);
    }
  } else if (friends is Friend) {
    // 단일 Friend 객체 저장
    await box.put(friends.id, friends);
  } else {
    throw ArgumentError('The argument must be a Friend or List<Friend>');
  }
}

Future<List<Friend>> getAllFriends() async {
  var box = await Hive.openBox<Friend>('friendsBox');
  List<Friend> friends = box.values.toList();
  await box.close();
  return friends;
}

//친구 중에서 이름으로 검색하는 기능
Future<List<Friend>> searchAndRetrieveFriends(String startsWith, String token) async {
  // 서버로부터 ID 목록을 가져옵니다.
  final String url = 'http://10.0.2.2:8080/members/friends/searchId/$startsWith';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // 서버로부터 정상적인 응답을 받았을 때
    List<dynamic> ids = json.decode(response.body);
    // Hive DB에서 해당하는 Friend 객체들을 검색합니다.
    var box = await Hive.openBox<Friend>('friendsBox');
    List<Friend> friendsList = [];
    for (var id in ids) {
      final friendId = id as int; // 서버로부터 받은 ID가 int 타입임을 가정합니다.
      final friend = box.get(friendId); // ID를 사용하여 Friend 객체를 검색합니다.
      if (friend != null) {
        friendsList.add(friend);
      }
    }
    return friendsList; // 검색된 Friend 객체들의 리스트를 반환합니다.
  } else {
    // 에러가 발생했을 때
    throw Exception('Failed to load friend ids');
  }
}

//아래 메서드는 친구를 추가하기 위해 아직 친국가 아닌 회원을 찾는 기능
Future<Tuple2<Friend, String>> findFriendByEmail(String email, String token) async {
  final String url = 'http:://10.0.2.2:8080/members/search/email/$email';
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
    int memberId = friendData['memberId'] ?? 0;
    String memberName = friendData['memberName'] ?? 'Unknown';
    String profileURL = friendData['profileURL'] ?? 'default.png';
    String friendStatus = friendData['friendStatus'];

    Friend tempFriend = Friend.fromJson({
      'friendId': memberId,
      'specifiedName': memberName,
      'birthDate': '1900-01-01', // 임의로 채운 값
      'profileURL': profileURL,
      'myGive': false, // 임의로 채운 값
      'myTake': false, // 임의로 채운 값
    });

    return Tuple2<Friend, String>(tempFriend, friendStatus);
  } else {
    throw Exception;
  }
}