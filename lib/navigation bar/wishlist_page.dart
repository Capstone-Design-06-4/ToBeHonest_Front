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

  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });
    await wishListController.fetchProgressWishItems_Con(searchText: _searchText);
  }

  @override
  void initState() {
    super.initState();
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
                            child: Text('위시리스트', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height:20),
                      ItemSearchBar(onSearch: _onSearch),
                      SizedBox(height:20),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Visibility(
                  visible: _searchText == "",
                  child:  ItemAddBar(context),
                ),
              SizedBox(height: 10,),
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
