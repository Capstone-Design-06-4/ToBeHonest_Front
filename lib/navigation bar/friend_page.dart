// friend_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/friend_search_controller.dart';
import '../friend_function/friend_widgets/friend_list_widget.dart';
import '../friend_function/friend_widgets/friend_search_widget.dart';
import '../friend_function/friend_widgets/friend_add_click.dart';
import '../friend_function/friend_widgets/friend_categorized_widget.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final FriendController friendController = Get.find<FriendController>();

  @override
  void initState() {
    super.initState();
    friendController.getFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    searchController.addListener(() {
      String searchQuery = searchController.text;
      friendController.isAddingAllowed.value = searchQuery.isEmpty;
      if (searchQuery.isNotEmpty) {
        friendController.searchFriends(searchQuery);
      } else {
        friendController.getFriendsList();
      }
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchFriendWidget(controller: searchController),
          Obx(() => Visibility(
            visible: friendController.isAddingAllowed.value,
              child: const AddFriendTile(),
            ),
          ),
          const FriendCategorized(title: '친구 목록'),
          Expanded(
            child: Obx(() {
              if (friendController.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: friendController.friendsList.length,
                itemBuilder: (context, index) {
                  return buildFriendContainer(context, friendController.friendsList[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
