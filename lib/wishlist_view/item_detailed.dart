import 'package:flutter/material.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/controllers/wishlist_search_controlller.dart';

class ItemDetailed extends StatelessWidget {
  final WishItem wishItem;

  ItemDetailed({required this.wishItem});

  @override
  Widget build(BuildContext context) {
    // 할인된 가격을 계산합니다.
    final double discountRate = wishItem.fundAmount / wishItem.itemPrice;
    final double discountedPrice = wishItem.itemPrice * (1 - discountRate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(wishItem.itemName, style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 이미지 부분
            Container(
              color: Colors.white,
              child: Image.network(wishItem.image, fit: BoxFit.contain),
            ),
            SizedBox(height: 16),
            // 상품 이름 및 브랜드
            Text(
              wishItem.itemBrand,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              wishItem.itemName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 16),
            // 가격 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(discountRate * 100).toStringAsFixed(0)}% 할인',
                  style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${discountedPrice.toInt()}원',
                  style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(${wishItem.itemPrice}원)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // 장바구니 추가 버튼
            ElevatedButton(
              onPressed: () {
                // 장바구니에 추가하는 로직을 구현하세요.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('장바구니에 추가', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}