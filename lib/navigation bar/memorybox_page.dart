// giftbox_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:tobehonest/memorybox_function/memorybox_widgets/used_item_list_widget.dart';
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
  // 필터 옵션 목록
  List<String> filterOptions = ['메시지 작성하지 않은 선물리스트', '메시지 작성한 선물리스트'];

  // 선택된 필터 옵션을 저장하는 변수
  String? selectedFilter;


  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });

    _updateWishItems();
  }

  void _updateWishItems() async {
    try {
      await memoryBoxController.fetchUsedWishItems_Con(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
    _updateWishItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ItemSearchBar(onSearch: _onSearch),
            Expanded(
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
                    child: selectedFilter == '메시지 작성하지 않은 선물리스트'
                        ? Obx(() {
                      if (memoryBoxController.isLoading.isTrue) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView(
                        children: <Widget>[
                          WishItemList(
                            wishItems: memoryBoxController.wishItems,
                            searchText: _searchText,
                          ),
                        ],
                      );
                    })
                        : _buildGiftListWithoutMessage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 메시지 작성한 선물리스트 표시
Widget _buildGiftListWithMessage() {
  return Center(
    child: Text('메시지 작성한 선물리스트'),
  );
}

// 메시지 작성하지 않은 선물리스트 표시
Widget _buildGiftListWithoutMessage() {
  return Center(
    child: Text('메시지 작성하지 않은 선물리스트'),
  );
}
