import 'package:flutter/material.dart';
import 'package:tobehonest/models/wishItem.dart';

class WishItemList extends StatelessWidget {
  final List<WishItem> wishItems;

  WishItemList({required this.wishItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishItems.length, // 목록의 전체 아이템 수
      itemBuilder: (context, index) {
        final item = wishItems[index];
        return ListTile(
          leading: Image.network(item.image, width: 60, height: 60, fit: BoxFit.cover), // 아이템 이미지
          title: Text(item.itemBrand), // 브랜드 이름
          subtitle: Text('${item.itemPrice.toString()}원'), // 가격
          trailing: Icon(Icons.arrow_forward_ios), // 리스트 타일의 끝에 아이콘
        );
      },
    );
  }
}
