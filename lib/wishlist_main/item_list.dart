import 'package:flutter/material.dart';
import 'package:tobehonest/wishlist_view/item_detailed.dart';
import 'package:tobehonest/models/wishItem.dart';

class WishItemList extends StatelessWidget {
  final List<WishItem> wishItems = List.generate(
    18,
        (index) => WishItem(
      wishItemId: index + 1,
      itemBrand: '브랜드 ${index + 1}',
      itemName: '제품 ${index + 1}',
      image: '이미지 URL', // 실제 이미지 URL로 수정
      itemPrice: 10000 + index * 800, // 실제 가격 계산에 맞게 수정
      fundAmount: 5000 + index * 1200, // 실제 펀드 금액 계산에 맞게 수정
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: wishItems.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailed(wishItem: wishItems[index]),
            ),
          );
        },
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.dashboard, // 적절한 아이콘으로 수정
                    size: 100,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${wishItems[index].itemName}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: (MediaQuery.of(ctx).size.width - 265) *
                          (wishItems[index].fundAmount / wishItems[index].itemPrice),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${(wishItems[index].fundAmount / wishItems[index].itemPrice * 100).toStringAsFixed(2)}%',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
