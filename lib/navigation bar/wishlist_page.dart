// wishlist_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_search_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_list_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_add_button_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';

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
      wishListController.isLoading(true);  // 로딩 시작
      await wishListController.fetchProgressWishItems_Con(searchText: _searchText);
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
            title: Text('위시리스트', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              ItemSearchBar(onSearch: _onSearch),
              ItemAddBar(context),
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
      ),
    );
  }
}
