import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/models/item.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_add/item_add_search_widget.dart';
import 'package:intl/intl.dart';

class NewItemPagebyCategory extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPagebyCategory> {
  final WishListController wishListController = Get.put(WishListController());
  int? selectedTileIndex;
  Item? selectedItem;

  void _handleSearch(String text) {
    print('검색어: $text');
    wishListController.ItemAddSearchbyCategory(text);
  }

  @override
  void initState() {
    super.initState();
    selectedTileIndex = null;
    selectedItem = null;
    wishListController.Items.clear(); // 전체 리스트 초기화
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("카테고리로 추가하기"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 15.0),
              // 검색 위젯
              ItemAddSearchBar(handleSearch: _handleSearch),
              SizedBox(height: 5.0),
              Obx(() {
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
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: selectedTileIndex == index ? AppColor.backgroundColor.withOpacity(0.5) : Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: Text(
                              item.brand,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  '금액: ${NumberFormat('#,###').format(item.price)} 원',
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
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

                      ModalUtils.showFriendModal(context, selectedItem!);
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(0, 36),
                  ),
                  child: FittedBox(
                    child: Text(
                      '위시리스트에 추가하기',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalUtils {
  static void showFriendModal(BuildContext context, Item selectedItem) {
    final WishListController wishListController = Get.put(WishListController());

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300, // 모달 높이 크기
            decoration: BoxDecoration(
              color: Colors.white, // 모달 배경색
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Container(
                  height: 60.0,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundColor: AppColor.swatchColor,
                        child: Icon(Icons.question_mark, color: Colors.white),
                      ),
                      title: Text(
                          '위시리스트에 추가하시겠어요?',
                        style: TextStyle(fontSize: 17),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context); // 예시: 현재 페이지를 닫음
                        },
                      ),
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                selectedItem.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    selectedItem.brand.length > 8
                                        ? '${selectedItem.brand.substring(0, 8)}...'
                                        : selectedItem.brand,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                selectedItem.name,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '펀딩 총액: ',
                                    style: TextStyle(fontSize: 18,),
                                  ),
                                  Text(
                                    '${formatNumber(selectedItem.price)}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textColor),
                                  ),
                                  Text(
                                    ' 원',
                                    style: TextStyle(fontSize: 18,),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () async {
                      await wishListController.addToWishlistWithSnackbar(selectedItem!);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },

                    child: FittedBox(
                      child: Text(
                        '추가하기',
                        style: TextStyle(fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.transparent
    );
  }
}