import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/services/contribute_service.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/friend_function/friend_widgets/friend_product_widget.dart';
import 'package:tobehonest/friend_function/friend_widgets/friend_contribute_widget.dart';
import 'package:tobehonest/controllers/friend_product_controller.dart';

class FriendItemDetailed extends StatefulWidget {
  final WishItem wishItem;
  final int friendID;

  FriendItemDetailed({required this.wishItem, required this.friendID});

  @override
  _ItemDetailedState createState() => _ItemDetailedState();
}

class _ItemDetailedState extends State<FriendItemDetailed> {

  late FriendProductController friendProductController;

  @override
  void initState() {
    super.initState();
    friendProductController = Get.put(FriendProductController(widget.wishItem, widget.friendID));
  }

  Future<void> onContributeButtonPressed() async {
    final WishItem wishItem = widget.wishItem;
    // 펀딩 금액을 입력받기 위한 TextEditingController
    TextEditingController amountController = TextEditingController();

    // 펀딩 금액 입력을 위한 팝업창 표시
    int? fundAmount = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("펀딩 금액 설정"),
          content: TextField(
            controller: amountController,
            decoration: InputDecoration(
              labelText: "금액 입력",
            ),
            keyboardType: TextInputType.number, // 숫자만 입력 가능
          ),
          actions: <Widget>[
            TextButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.of(context).pop(); // 취소시 대화 상자 닫기
              },
            ),
            TextButton(
              child: Text("확인"),
              onPressed: () {
                int? amount = int.tryParse(amountController.text); // 입력된 금액을 int로 변환
                Navigator.of(context).pop(amount); // 확인시 금액 반환
              },
            ),
          ],
        );
      },
    );
    String? token = await getToken();
    if(token == null) throw Exception('다시 로그인하세요.');
    if (fundAmount != null && fundAmount > 0) {
      // 펀딩 금액이 유효한 경우 펀딩 처리
      try {
        final response = await contributeToFriend(wishItem, fundAmount, widget.friendID, token);
        await friendProductController.updateWishItem();
        // 이후의 로직은 위와 동일
      } catch (e) {
        // 오류 처리
        print('오류 발생: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final WishItem wishItem = widget.wishItem;

    final double fundingProgress = wishItem.fundAmount / wishItem.itemPrice;

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('상세보기', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Obx(() => FriendProductWidget(
                      friendID: widget.friendID,
                      wishItem: friendProductController.wishItem.value,
                    )),
                    FriendContributeWidget(onContribute: () async {
                      await onContributeButtonPressed();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}