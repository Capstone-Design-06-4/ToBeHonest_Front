// friend_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
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
    _updateWishItems();
  }

  void _updateWishItems() async {
    try {
      friendController.isLoading(true);  // 로딩 시작
      await friendController.getFriendsList();
      friendController.friendsList.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      friendController.isLoading(false);  // 로딩 종료
    }
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

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor,
            title: Text('친구', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SearchFriendWidget(controller: searchController),
              Obx(() {
                return Visibility(
                  visible: friendController.isAddingAllowed.value,
                  child: AddFriendTile(),
                );
              }),
              FriendCategorized(title: '친구 목록'),
              SizedBox(height: 5),
              Expanded(
                child: Obx(() {
                  if (friendController.isLoading.isTrue) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: friendController.friendsList.length,
                    itemBuilder: (context, index) {
                      return buildFriendContainer(
                          context, friendController.friendsList[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
