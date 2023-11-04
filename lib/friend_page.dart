import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/friend_list_widget.dart';
import '../widgets/friend_search_widget.dart';
import '../widgets/friend_add_widget.dart';
import '../widgets/friend_categorized_widget.dart';

class FriendPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
}
