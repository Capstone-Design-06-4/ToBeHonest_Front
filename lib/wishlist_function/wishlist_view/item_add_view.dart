import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/models/item.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_add/item_add_search_widget.dart';

class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final WishListController wishListController = Get.put(WishListController());
  int? selectedTileIndex;
  Item? selectedItem; // 선택된 아이템 저장 변수

  void _handleSearch(String text) {
    print('검색어: $text');
    wishListController.ItemAddSearch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("새로운 상품 추가하기"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            // 검색 위젯
            ItemAddSearchBar(handleSearch: _handleSearch),
            Obx(
                  () {
                return Expanded(
                  child: ListView.builder(
                    itemCount: wishListController.Items.length,
                    itemBuilder: (context, index) {
                      Item item = wishListController.Items[index];
                      return GestureDetector(
                        onTap: () {
                          // 탭할 때마다 선택 상태 변경
                          setState(() {
                            if (selectedTileIndex == index) {
                              // 이미 선택된 타일을 다시 누르면 선택 취소
                              selectedTileIndex = null;
                              selectedItem = null; // 선택 취소 시 selectedItem도 초기화
                            } else {
                              // 다른 타일을 누르면 해당 타일 선택
                              selectedTileIndex = index;
                              selectedItem = item; // 선택한 아이템 저장
                            }
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: selectedTileIndex == index ? Colors.yellow : null,
                            leading: Image.network(
                              item.image,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.brand),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text('금액: ${NumberFormat('#,###').format(item.price)} 원'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 15.0),
            // 위시리스트에 추가 버튼
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: selectedTileIndex != null
                    ? () async {
                  // ListTile이 선택된 경우에만 버튼 동작
                  // 버튼 동작 시 로직 추가
                  if (selectedItem != null) {
                    print('선택한 상품 추가: ${selectedItem!.name}');
                    print('선택한 상품 가격: ${selectedItem!.price}');

                    // 여기에 위시리스트에 추가하는 로직을 추가하세요.
                    await wishListController.addToWishlistWithSnackbar(selectedItem!);
                    Navigator.pop(context);
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(0, 36),
                ),
                child: FittedBox(
                  child: Text(
                    '위시리스트에 추가',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
