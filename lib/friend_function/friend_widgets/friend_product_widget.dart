import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_product_controller.dart';
import 'package:tobehonest/models/wishItem.dart';

class FriendProductWidget extends StatefulWidget {
  final int friendID;
  final WishItem wishItem;
  final String friendName;
  FriendProductWidget({Key? key, required this.friendName, required this.friendID, required this.wishItem}) : super(key: key);

  @override
  _FriendProductWidgetState createState() => _FriendProductWidgetState();
}

class _FriendProductWidgetState extends State<FriendProductWidget> {
  late FriendProductController controller;

  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화 및 상태 가져오기
    controller =
        Get.put(FriendProductController(widget.wishItem, widget.friendID));
    controller.updateWishItem();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final wishItem = controller.wishItem.value;
      double fundingProgress = wishItem.fundAmount / wishItem.itemPrice;

      String formatNumber(int number) {
        final formatter = NumberFormat('#,###');
        return formatter.format(number);
      }

      return Column(
        children: [
          Container(
            width: 320,
            height: 320,
            margin: EdgeInsets.symmetric(vertical:10, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  wishItem.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            width: 360,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        wishItem.itemBrand.length > 8
                            ? '${wishItem.itemBrand.substring(0, 8)}...'
                            : wishItem.itemBrand,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), // 여기서 Spacer를 사용하여 공간을 꽉 채웁니다.
                      Text(
                        '${formatNumber(wishItem.itemPrice)}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.textColor),
                      ),
                      Text(
                        ' 원',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    wishItem.itemName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: FractionalOffset(fundingProgress >= 1 ? 1 : fundingProgress, 0.0),
            child: FractionallySizedBox(
              child: Icon(
                Icons.arrow_drop_down, // 아이콘으로 대체
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Stack(
                children: [
                  Container(
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: fundingProgress >= 1 ? 1 : fundingProgress,
                    child: Container(
                      height: 22,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '펀딩 완료!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '펀딩액의  ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '${(wishItem.fundAmount/wishItem.itemPrice*100).toStringAsFixed(2)}%',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor),
                      ),
                      Text(
                        '  쌓였어요.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}