import 'package:flutter/material.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';

Widget ItemAddBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      children: [
        SizedBox(height: 5.0),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewItemPage(),
            ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.grey),
                    SizedBox(width: 10.0),
                    Text(
                      '위시리스트에 상품 추가하기',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}