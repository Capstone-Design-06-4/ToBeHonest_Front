import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/friend.dart';

class FriendService {
  Future<List<Friend>> fetchFriends() async {
    final response = await http.get(Uri.parse('YOUR_API_URL'));

    if (response.statusCode == 200) {
      List<dynamic> friendJsonList = jsonDecode(response.body);
      List<Friend> friends = friendJsonList.map((json) => Friend.fromJson(json)).toList();
      return friends;
    } else {
      throw Exception('Failed to load friends');
    }
  }
}
