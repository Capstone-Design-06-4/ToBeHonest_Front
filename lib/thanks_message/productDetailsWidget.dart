import 'package:flutter/material.dart';
import '../models/wishItem.dart'; // WishItem 클래스를 포함하는 파일을 import

class ProductDetailsWidget extends StatelessWidget {
  final WishItem wishItem;

  const ProductDetailsWidget({
    Key? key,
    required this.wishItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        '₩${wishItem.itemPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    final formattedFundAmount =
        '₩${wishItem.fundAmount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Image.network(wishItem.image),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    wishItem.itemBrand,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    wishItem.itemName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(children: [
                    Text(
                      '펀딩 모금액',
                      style:
                          TextStyle(fontSize: 16, color: Colors.orangeAccent),
                    ),
                    Text(
                      " $formattedFundAmount",
                      style:
                          TextStyle(fontSize: 16, color: Colors.orangeAccent),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
