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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.objectColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.objectColor,
            title: Text(
              '친구',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColor.textColor,
              ),
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
