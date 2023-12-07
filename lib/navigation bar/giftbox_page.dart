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
  final ScrollController _scrollController = ScrollController();

  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });
    await _update();
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
          preferredSize: Size.fromHeight(70), // 조절하고자 하는 높이로 변경
          child: AppBar(
            elevation: 0, // 그림자 제거
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor.withAlpha(200),
            title: Text(' \n선물함', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23, color: Colors.white)),
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
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Column(
                    children: [
                      ItemSearchBar(onSearch: _onSearch),
                      SizedBox(height:10),
                    ],
                  ),
                ),
              ),
              SizedBox(height:5),
              Obx(() {
                if (giftBoxController.isLoading.isTrue) {
                  return Center(child: CircularProgressIndicator());
                }
                else if(giftBoxController.wishItems.length == 0) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Text('선물함이 비었어요.',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  );
                }
                return WishItemList(
                  wishItems: giftBoxController.wishItems,
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
