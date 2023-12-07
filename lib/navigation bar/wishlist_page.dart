// wishlist_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final ScrollController _scrollController = ScrollController();

  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });
    await _update();
  }

  Future<void> _update() async {
    try {
      await wishListController.fetchProgressWishItems_Con(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  void _scrollToTop() {
    setState(() {
      _scrollController.jumpTo(0);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70), // 조절하고자 하는 높이로 변경
          child: AppBar(
            elevation: 0, // 그림자 제거
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor.withOpacity(0.8), // 완전 투명
            title: Text(' \n위시리스트', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23, color: Colors.white)),
            actions: [
              Container(
                margin: EdgeInsets.only(top:25,right: 20), // 원하는 만큼의 마진을 설정
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowUp),
                  onPressed: () {
                    _scrollToTop();
                  },
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
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
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      ItemSearchBar(onSearch: _onSearch),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              ItemAddBar(context),
              SizedBox(height: 5),
              Obx(() {
                if (wishListController.isLoading.isTrue) {
                  return Center(child: CircularProgressIndicator());
                }
                else if(wishListController.wishItems.length ==0) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Text('위시리스트가 비었어요.\n원하는 상품을 추가해볼까요?',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  );
                }
                return WishItemList(
                  wishItems: wishListController.wishItems,
                  searchText: _searchText,
                );
              }),
            ],
          ),
        ),

      ),
    );
  }
}
