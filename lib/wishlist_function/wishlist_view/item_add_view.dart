import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tobehonest/controllers/switch_controllers.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/models/item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_add/item_add_search_widget.dart';
import 'package:tobehonest/controllers/expect_controller.dart';

class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final WishListController wishListController = Get.put(WishListController());
  final ExpectController expectController = Get.put(ExpectController());

  int? fundSucess;
  int? selectedTileIndex;
  Item? selectedItem;

  void _handleSearch(String text) {
    print('검색어: $text');
    wishListController.ItemAddSearch(text);
  }

  @override
  void initState() {
    super.initState();
    selectedTileIndex = null;
    selectedItem = null;
    wishListController.Items.clear(); // 전체 리스트 초기화
  }

  // 페이지 초기화 함수
  void _resetPage() {
    // 현재 페이지를 팝하고 다시 푸시하여 페이지를 초기화하고 다시 그림
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NewItemPage()),
    );
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
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: AppColor.backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('상품이름을 검색해보세요!', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height:20),
                    ItemAddSearchBar(handleSearch: _handleSearch),
                    SizedBox(height:20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10,bottom: 5),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: selectedTileIndex == index ? AppColor.swatchColor.withAlpha(150) : Colors.white,
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
                                Row(
                                  children: [
                                    Text(
                                      '금액: ',
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      '${NumberFormat('#,###').format(item.price)}',
                                      style: TextStyle(fontSize: 16, color: selectedTileIndex == index ? Colors.black : AppColor.textColor),
                                    ),
                                    Text(
                                      '원',
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                    double fundSucess = await expectController.getPercentage(selectedItem!.id);

                    // 여기에 위시리스트에 추가하는 로직을 추가하세요.
                    ModalUtils.showFriendModal(context, selectedItem!,fundSucess!);
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
    );
  }
}

class ModalUtils {
  static void showFriendModal(BuildContext context, Item selectedItem, double fundSucess) {
    final WishListController wishListController = Get.put(WishListController());
    final switchController controller = Get.put(switchController());

    controller.isLiked.value = false;

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 380, // 모달 높이 크기
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
                  height: 80.0,
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
                GestureDetector(
                  onTap: () {
                    controller.toggleLike();
                  },
                  child: Container(
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
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    selectedItem.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Obx(
                                      () => Visibility(
                                    visible: controller.isLiked.value,
                                    child: Container(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 100,
                                      height: 100,
                                      child: CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: fundSucess/100, //여기에 계산값 넣기
                                        center: Text(
                                          '${fundSucess.toInt()} %', // Convert double to int
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        circularStrokeCap: CircularStrokeCap.round,
                                        progressColor: Colors.orangeAccent[400],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Stack(
                              children: [
                                Center(
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
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => Container(
                                  constraints: BoxConstraints(
                                    maxWidth: double.infinity, // 화면 전체를 차지하도록 최대 가로 길이를 설정
                                  ),
                                  color: Colors.white,
                                  child: Visibility(
                                    visible: controller.isLiked.value,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: double.infinity, // 화면 전체를 차지하도록 최대 가로 길이를 설정
                                                ),
                                                color: Colors.white,
                                                child: Text(
                                                  fundSucess >= 80
                                                      ? '좋아요!'
                                                      : 'Oops..',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: double.infinity, // 화면 전체를 차지하도록 최대 가로 길이를 설정
                                            ),
                                            color: Colors.white,
                                            child: Text(
                                              fundSucess >= 80
                                                  ? '펀딩에 충분히 성공할 거에요!'
                                                  : '펀딩액 달성이 어려울 것 같은데요?',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: double.infinity, // 화면 전체를 차지하도록 최대 가로 길이를 설정
                                            ),
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '펀딩 성공확률: ',
                                                  style: TextStyle(fontSize: 18,),
                                                ),
                                                Text(
                                                  '${'$fundSucess'}',
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textColor),
                                                ),
                                                Text(
                                                  ' %',
                                                  style: TextStyle(fontSize: 18,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: [
                      Text(
                        '상품 탭을 눌러 펀딩 성공확률을 확인하세요!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Obx(
                            () => Visibility(
                          visible: controller.isLiked.value,
                          child: Container(
                            color: Colors.white,
                            child:  Text(
                              '상품 탭을 눌러 펀딩 상품정보를 확인하세요!',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),

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


