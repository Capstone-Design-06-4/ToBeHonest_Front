// friend_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import '../controllers/friend_search_controller.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';
import '../friend_function/friend_widgets/friend_list_widget.dart';
import '../friend_function/friend_widgets/friend_search_widget.dart';
import '../friend_function/friend_widgets/friend_add_click.dart';
import '../friend_function/friend_widgets/friend_categorized_widget.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  //final FriendController friendController = Get.find<FriendController>();
  final FriendController friendController = Get.put(FriendController());
  final AddController addController = Get.put(AddController());

  @override
  void initState() {
    super.initState();
  }

  Future<void> _update() async {
    try {
      await friendController.getFriendsList();
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    searchController.addListener(() async {
      String searchQuery = searchController.text;
      friendController.isAddingAllowed.value = searchQuery.isEmpty;
      if (searchQuery.isNotEmpty) {
        await friendController.searchFriends(searchQuery);
      } else {
        await friendController.getFriendsList();
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: AppColor.backgroundColor.withAlpha(200),
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, // 아이콘을 감싸는 배경 색상 설정 (필요에 따라 변경)
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.userFriends, // "friend"에 해당하는 아이콘
                                  size: 20.0, // 아이콘의 크기 설정
                                  color: AppColor.swatchColor, // 아이콘의 색상 설정
                                ),
                              ),
                            ),

                            SizedBox(width: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('친구', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height:20),
                        SearchFriendWidget(controller: searchController),
                        SizedBox(height:20),
                      ],
                    ),
                  ),
              ),
              SizedBox(height:10),
              Obx(() {
                return Visibility(
                  visible: friendController.isAddingAllowed.value,
                  child: AddFriendTile(),
                );
              }),
              SizedBox(height:10),
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
