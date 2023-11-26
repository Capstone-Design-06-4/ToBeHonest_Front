import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import '../models/wishItem.dart'; // WishItem 클래스를 포함하는 파일을 import

class ProductDetailsWidget extends StatelessWidget {
  final WishItem wishItem;

  const ProductDetailsWidget({
    Key? key,
    required this.wishItem,
  }) : super(key: key);

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                    wishItem.image,
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
                        wishItem.itemBrand.length > 8
                            ? '${wishItem.itemBrand.substring(0, 8)}...'
                            : wishItem.itemBrand,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    wishItem.itemName,
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
                        '${formatNumber(wishItem.fundAmount)}',
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
    );
  }
}
