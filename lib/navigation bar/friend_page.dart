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
  //final FriendController friendController = Get.find<FriendController>();
  final FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    super.initState();
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
                              width: 45.0, // 원형 이미지의 가로 크기
                              height: 45.0, // 원형 이미지의 세로 크기
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // 원형 모양 지정
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'), // 이미지 경로 지정
                                  fit: BoxFit.fill, // 이미지가 컨테이너를 완전히 채우도록 설정
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('친구', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white)),
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
