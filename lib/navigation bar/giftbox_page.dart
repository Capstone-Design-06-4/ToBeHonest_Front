// giftbox_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });
    await _update();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _update() async {
    try {
      await giftBoxController.fetchCompleteWishItems_Con(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
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
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // 아이콘을 감싸는 배경 색상 설정 (필요에 따라 변경)
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.gifts, // "friend"에 해당하는 아이콘
                                size: 20.0, // 아이콘의 크기 설정
                                color: AppColor.swatchColor, // 아이콘의 색상 설정
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('선물함', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white)),
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
