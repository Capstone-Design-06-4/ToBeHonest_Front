import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_product_controller.dart';
import 'package:tobehonest/models/wishItem.dart';

class FriendProductWidget extends StatefulWidget {
  final int friendID;
  final WishItem wishItem;

  FriendProductWidget({Key? key, required this.friendID, required this.wishItem}) : super(key: key);

  @override
  _FriendProductWidgetState createState() => _FriendProductWidgetState();
}

class _FriendProductWidgetState extends State<FriendProductWidget> {
  late FriendProductController controller;

  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화 및 상태 가져오기
    controller = Get.put(FriendProductController(widget.wishItem, widget.friendID));
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
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.35,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                wishItem.image,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    wishItem.itemBrand,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              wishItem.itemName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 20,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * fundingProgress,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '펀딩 모금액',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '${formatNumber(wishItem.fundAmount)}원 / ${formatNumber(
                    wishItem.itemPrice)}원',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      );
    });
  }
}