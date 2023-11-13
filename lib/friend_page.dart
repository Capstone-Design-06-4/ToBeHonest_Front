// friend_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/friend_controller.dart';
import '../widgets/friend_list_widget.dart';
import '../widgets/friend_search_widget.dart';
import '../widgets/friend_add_widget.dart';
import '../widgets/friend_categorized_widget.dart';

class FriendPage extends StatelessWidget {
  final FriendController friendController = Get.find<FriendController>();

  FriendPage({Key? key}) : super(key: key);

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
