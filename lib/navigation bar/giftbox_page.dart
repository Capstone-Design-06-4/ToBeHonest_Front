// giftbox_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/controllers/giftbox_controller.dart';
import 'package:tobehonest/giftbox_function/giftbox_widgets/completeted_item_search_widget.dart';
import 'package:tobehonest/giftbox_function/giftbox_widgets/com_item_list_widget.dart';
import 'package:tobehonest/giftbox_function/giftbox_view/com_item_detailed_view.dart';
import 'package:get/get.dart';

class GiftBoxPage extends StatefulWidget {
  @override
  _GiftBoxPageState createState() => _GiftBoxPageState();
}

class _GiftBoxPageState extends State<GiftBoxPage> {
  String _searchText = ''; // 추가: 검색어 저장 변수
  final GiftBoxController giftBoxController = Get.put(GiftBoxController());

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    _updateWishItems();
  }

  Future<void> _updateWishItems() async {
    try {
      giftBoxController.isLoading(true);  // 로딩 시작
      await giftBoxController.fetchCompleteWishItems_Con(searchText: _searchText);
      giftBoxController.wishItems.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      giftBoxController.isLoading(false);  // 로딩 종료
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _updateWishItems()); //이건 명시하는거지 비동기로 실행하는 것이 아님. 수정 필요
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
            title: Text('선물함', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              ItemSearchBar(onSearch: _onSearch),
              Expanded(
                child: Obx(() {
                  if (giftBoxController.isLoading.isTrue) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children: <Widget>[
                      WishItemList(
                        wishItems: giftBoxController.wishItems,
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
