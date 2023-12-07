//item_list.dart

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/friend_function/friend_view/friend_item_detailed_view.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/controllers/friend_product_controller.dart';
import 'package:get/get.dart';

class FriendWishItemList extends StatelessWidget {
  final List<WishItem> wishItems;
  final int friendID;
  final String searchText;
  final String friendName;

  FriendWishItemList({required this.friendName, required this.wishItems, required this.friendID, required this.searchText});

  @override
  Widget build(BuildContext context) {
    List<WishItem> filteredWishItems = _filterWishItems();
    final FriendProductController friendProductController = Get.put(FriendProductController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredWishItems.length,
        itemBuilder: (ctx, index) => InkWell(
          onTap: () async {
            await friendProductController.setWishItemAndFriendID(filteredWishItems[index], friendID);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FriendItemDetailed(friendName: friendName, wishItem: filteredWishItems[index], friendID: friendID,),
              ),
            );
          },
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          filteredWishItems[index].image,
                          fit: BoxFit.fill,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${filteredWishItems[index].itemName}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                        child: LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          animation: true,
                          animationDuration: 1200,
                          lineHeight: 22.0,
                          percent: filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice >= 1.0 ? 1.0 : filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice,
                          barRadius: Radius.circular(16.0),
                          progressColor: Colors.green[400],
                          linearStrokeCap: LinearStrokeCap.roundAll,  // 이 속성을 추가하여 선의 끝 부분을 둥글게 만듭니다.
                          backgroundColor: Colors.grey[200],  // Container의 배경색과 동일한 효과를 위해 추가했습니다.
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: (filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice * 100) > 70
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<WishItem> _filterWishItems() {
    return wishItems
        .where((item) =>
        item.itemName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
