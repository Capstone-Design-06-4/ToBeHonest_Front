// friend_wishlist_view.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';
import 'package:tobehonest/friend_function/friend_widgets/friend_item_list_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_search_widget.dart';

class FriendWishlistPage extends StatefulWidget {
  final int friendID;
  final String friendName;

  FriendWishlistPage({Key? key, required this.friendName, required this.friendID}) : super(key: key);

  @override
  _FriendWishlistPageState createState() => _FriendWishlistPageState();
}

class _FriendWishlistPageState extends State<FriendWishlistPage> {
  String _searchText = '';
  final FriendWishListController wishListController = Get.put(FriendWishListController());

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    _updateWishItems();
  }

  void _updateWishItems() async {
    try {
      wishListController.isLoading(true); // 로딩 시작
      await wishListController.fetchFriendWishItems_Con(
          friendID: widget.friendID, searchText: _searchText);
      // RxList를 refresh하여 UI를 갱신
      wishListController.wishItems.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      wishListController.isLoading(false); // 로딩 종료
    }
  }

  @override
  void initState() {
    super.initState();
    _updateWishItems();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text('${widget.friendName}님의 위시리스트', style: TextStyle(color: Colors.white)),
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
                  color: AppColor.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('${widget.friendName}님의 위시리스트', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white)),
                          ),
                        ],
                      ),
                      ItemSearchBar(onSearch: _onSearch),
                      SizedBox(height:10),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Obx(() {
                  if (wishListController.isLoading.isTrue) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Offstage(
                    offstage: true, // 이 위젯을 레이아웃에서 제외하지만, 상태 변화는 여전히 추적
                    child: Text(
                      'Count: ${wishListController.count}',
                      style: TextStyle(
                        color: Colors.transparent, // 텍스트를 투명하게
                      ),
                    ),
                  );
                  if (wishListController.isLoading.isTrue) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(wishListController.wishItems.length == 0) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0),
                      child: Text('${widget.friendName}님의 위시리스트가 비었어요.',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    );
                  }
                  return ListView(
                    children: <Widget>[
                      FriendWishItemList(
                        wishItems: wishListController.wishItems,
                        friendID: widget.friendID,
                        searchText: _searchText,
                        friendName: widget.friendName,
                      ),
                    ],
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
