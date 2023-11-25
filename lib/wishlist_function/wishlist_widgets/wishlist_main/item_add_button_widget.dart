import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';

Widget ItemAddBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewItemPage(),
            ));
          },
          child: Container(
            height: 70.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: CircleAvatar(
                backgroundColor: AppColor.swatchColor,
                child: Icon(Icons.favorite, color: Colors.white),
              ),
              title: Text('상품 추가하기'),
              subtitle: Text('위시리스트에 선물을 추가해요!'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    ),
  );
}