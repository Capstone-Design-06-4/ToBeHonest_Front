import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                '   펀딩을 해볼까요?',
                style: TextStyle(
                  fontSize: 28, // 글씨 크기 조절
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
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
                        wishItem.itemBrand.length > 5
                            ? '${wishItem.itemBrand.substring(0, 5)}...'
                            : wishItem.itemBrand,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), // 여기서 Spacer를 사용하여 공간을 꽉 채웁니다.
                      Text(
                        '펀딩액: ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${formatNumber(wishItem.fundAmount)}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.textColor),
                      ),
                      Text(
                        ' 원  ',
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
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
            child: LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              animation: true,
              animationDuration: 1200,
              lineHeight: 22.0,
              percent: fundingProgress >= 1.0 ? 1.0 : fundingProgress,
              barRadius: Radius.circular(16.0),
              progressColor: Colors.green[400],
              linearStrokeCap: LinearStrokeCap.roundAll,  // 이 속성을 추가하여 선의 끝 부분을 둥글게 만듭니다.
              backgroundColor: Colors.grey[200],  // Container의 배경색과 동일한 효과를 위해 추가했습니다.
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.friendName}',
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${fundingProgress > 1 ? ' 님의 위시리스트 펀딩 완료!' : '님의 위시리스트 펀딩 중!'}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                    ],
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
                        ' 가  모였어요.',
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