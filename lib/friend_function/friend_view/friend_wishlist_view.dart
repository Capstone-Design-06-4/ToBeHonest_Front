// friend_wishlist_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_search_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_list_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_add_button_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';

class friendWishlistPage extends StatefulWidget {
  final int friendID;

  friendWishlistPage({Key? key, required this.friendID}) : super(key: key);

  @override
  _friendWishlistPageState createState() => _friendWishlistPageState();
}

class _friendWishlistPageState extends State<friendWishlistPage> {
  String _searchText = '';
  final friendWishListController wishListController = Get.put(friendWishListController());

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });

    _updateWishItems();
  }

  void _updateWishItems() async {
    try {
      wishListController.isLoading(true);  // 로딩 시작
      await wishListController.fetchFriendWishItems_Con(friendID: widget.friendID, searchText: _searchText);
      // RxList를 refresh하여 UI를 갱신
      wishListController.wishItems.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      wishListController.isLoading(false);  // 로딩 종료
    }
  }

  @override
  void initState() {
    super.initState();

    // 페이지가 열릴 때 자동으로 새로고침
    _updateWishItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ItemSearchBar(onSearch: _onSearch),
            Expanded(
              child: Obx(() {
                if (wishListController.isLoading.isTrue) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: <Widget>[
                    WishItemList(
                      wishItems: wishListController.wishItems,
                      searchText: _searchText,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
