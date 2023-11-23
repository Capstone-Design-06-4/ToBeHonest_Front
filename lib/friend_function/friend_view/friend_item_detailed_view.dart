import 'package:flutter/material.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/services/contribute_service.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:intl/intl.dart';

class FriendItemDetailed extends StatefulWidget {
  final WishItem wishItem;
  final int friendID;

  FriendItemDetailed({required this.wishItem, required this.friendID});

  @override
  _ItemDetailedState createState() => _ItemDetailedState();
}

class _ItemDetailedState extends State<FriendItemDetailed> {
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.35,
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
                          width: MediaQuery.of(context).size.width * fundingProgress,
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
                          '${formatNumber(wishItem.fundAmount)}원 / ${formatNumber(wishItem.itemPrice)}원',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () async {
                          await onContributeButtonPressed();
                        },
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
                            '펀딩하기',
                            style: TextStyle(fontSize: 16),
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
    );
  }
}