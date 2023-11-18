import 'package:flutter/material.dart';
import '../controllers/wishlist_search_controlller.dart';
import '../wishlist_main/item_search.dart';
import '../wishlist_main/item_list.dart';
import '../wishlist_view/item_add.dart';
import 'package:get/get.dart';

class Wishlist_Page extends StatefulWidget {
  @override
  _Wishlist_PageState createState() => _Wishlist_PageState();
}

class _Wishlist_PageState extends State<Wishlist_Page> {
  String _searchText = '';
  final WishListController wishListController = Get.put(WishListController());

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemSearchBar(onSearch: _onSearch),
        Expanded(
          child: Obx(
                () {
              if (wishListController.wishItems.isEmpty) {
                // 데이터 로딩 중 화면
                return Center(child: CircularProgressIndicator());
              } else {
                // 위시 아이템이 로드된 경우 위젯을 구성
                return ListView(
                  children: <Widget>[
                    ItemAddBar(context),
                    WishItemList(),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
