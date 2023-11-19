import 'package:flutter/material.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:intl/intl.dart';

class ItemDetailed extends StatelessWidget {
  final WishItem wishItem;

  ItemDetailed({required this.wishItem});

  @override
  Widget build(BuildContext context) {
    // 펀딩 진행률을 계산합니다. 모금액 / 총 금액
    final double fundingProgress = wishItem.fundAmount / wishItem.itemPrice;
    final double discountRate = wishItem.fundAmount / wishItem.itemPrice;
    final double discountedPrice = wishItem.itemPrice * (1 - discountRate);

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }

    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.51,
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.black, // 배경색을 흰색으로 설정
                borderRadius: BorderRadius.circular(12), // 모서리를 둥글게 처리
                boxShadow: [ // 그림자 효과 추가
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // 그림자 위치 변경
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // 이미지 모서리도 둥글게 처리
                child: Image.network(
                  wishItem.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 16),
            Text(wishItem.itemBrand, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(wishItem.itemName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
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
            SizedBox(height: 24),
            Container(
              width: 150, // 원하는 버튼의 폭으로 설정
              child: ElevatedButton(
                onPressed: () {
                  // 펀딩한 사람 보여주기 기능 구현
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8), // 내부 패딩 줄임
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(0, 36), // 최소 크기 설정
                ),
                child: FittedBox(
                  child: Text(
                    '참여한 사람 보기',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
