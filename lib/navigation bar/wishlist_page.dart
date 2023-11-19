// wishlist_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import '../wishlist_main/item_search.dart';
import '../wishlist_main/item_list.dart';
import '../wishlist_view/item_add.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  String _searchText = '';
  final WishListController wishListController = Get.put(WishListController());

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });

    _updateWishItems();
  }

  void _updateWishItems() async {
    try {
      await wishListController.fetchWishItems(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemSearchBar(onSearch: _onSearch),
        Expanded(
          child: Obx(() {
            if (wishListController.isLoading.isTrue) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: <Widget>[
                ItemAddBar(context),
                WishItemList(
                  wishItems: wishListController.wishItems,
                  searchText: _searchText,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
