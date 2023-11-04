import 'package:flutter/material.dart';

import '../models/friend.dart';

import '../services/friend_service.dart';

import '../widgets/friend_list_widget.dart';
import '../widgets/friend_search_widget.dart';
import '../widgets/friend_add_widget.dart';
import '../widgets/friend_categorized_widget.dart';

class FriendPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Friend>>(
      future: getAllFriends(), // 비동기 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 오류가 발생한 경우 오류 메시지를 표시합니다.
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
          // 데이터가 없는 경우 메시지를 표시합니다.
          return Center(child: Text('친구가 없습니다.'));
        } else {
          // 데이터가 있는 경우 친구 목록을 표시합니다.
          List<Friend> friends = snapshot.data!; // 데이터를 가져옵니다.

          return ListView(
            children: <Widget>[
              const SearchFriendWidget(),
              const AddFriendTile(),
              const FriendCategorized(title: '친구 목록'),
              SizedBox(height: 10),
              ...friends.map((friend) => buildFriendContainer(context, friend)).toList(),
            ],
          );
        }
      },
    );
  }
}
