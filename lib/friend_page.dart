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
    // 검색 컨트롤러를 FriendController와 연결합니다.
    final TextEditingController searchController = TextEditingController();
    searchController.addListener(() {
      // 텍스트가 변경될 때마다 검색을 실행합니다.
      String searchQuery = searchController.text;
      if (searchQuery.isNotEmpty) {
        friendController.searchFriends(searchQuery);
      } else {
        // 텍스트가 비었다면, 모든 친구를 다시 불러옵니다.
        friendController.fetchFriends();
      }
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchFriendWidget(controller: searchController), // onSearch를 제거했습니다.
          const AddFriendTile(),
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