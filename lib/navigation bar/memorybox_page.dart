// giftbox_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:tobehonest/controllers/usedbox_controller.dart';
import 'package:tobehonest/memorybox_function/memorybox_widgets/used_item_list_widget.dart';
import 'package:tobehonest/memorybox_function/memorybox_widgets/messaged_item_list_widget.dart';
import 'package:tobehonest/memorybox_function/memorybox_widgets/used_item_search_widget.dart';
import 'package:tobehonest/memorybox_function/memorybox_view/used_item_detailed_view.dart';
import 'package:tobehonest/giftbox_function/giftbox_view/com_item_detailed_view.dart';
import 'package:get/get.dart';


class MemoryBoxPage extends StatefulWidget {
  @override
  _MemoryBoxPageState createState() => _MemoryBoxPageState();
}

class _MemoryBoxPageState extends State<MemoryBoxPage> {
  String _searchText = ''; // 추가: 검색어 저장 변수
  final MemoryBoxController memoryBoxController = Get.put(MemoryBoxController());
  final ThankBoxController thankBoxController = Get.put(ThankBoxController());

  // 필터 옵션 목록
  List<String> filterOptions = ['작성 안한 선물', '작성한 선물'];

  // 선택된 필터 옵션을 저장하는 변수
  String? selectedFilter;


  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });

    await _update();
  }

  Future<void> _update() async {
    try {
      await memoryBoxController.fetchUsedWishItems_Con(searchText: _searchText);
      await thankBoxController.fetchThnakWishItems_Con(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
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
            title: Text('기억함', style: TextStyle(color: Colors.white)),
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
                                FontAwesomeIcons.brain, // "friend"에 해당하는 아이콘
                                size: 20.0, // 아이콘의 크기 설정
                                color: AppColor.swatchColor, // 아이콘의 색상 설정
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('기억함', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white)),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        value: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value;
                          });
                        },
                        items: filterOptions.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: '감사메시지',
                        ),
                      ),
                      // 선택된 필터에 따른 내용 표시
                      Expanded(
                        child: selectedFilter == '작성 안한 선물'
                            ? Obx(() {
                          if (memoryBoxController.isLoading.isTrue) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ListView(
                            children: <Widget>[
                              UsedWishItemList(
                                wishItems: memoryBoxController.wishItems,
                                searchText: _searchText,
                              ),
                            ],
                          );
                        })
                            : Obx(() {
                          if (thankBoxController.isLoading.isTrue) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ListView(
                            children: <Widget>[
                              MessagedWishItemList(
                                wishItems: thankBoxController.wishItems,
                                searchText: _searchText,
                              ),
                            ],
                          );
                        })
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
