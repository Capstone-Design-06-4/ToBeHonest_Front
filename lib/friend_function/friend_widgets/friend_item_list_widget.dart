//item_list.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/friend_function/friend_view/friend_item_detailed_view.dart';
import 'package:tobehonest/models/wishItem.dart';

class FriendWishItemList extends StatelessWidget {
  final List<WishItem> wishItems;
  final int friendID;
  final String searchText;

  FriendWishItemList({required this.wishItems, required this.friendID, required this.searchText});

  @override
  Widget build(BuildContext context) {
    List<WishItem> filteredWishItems = _filterWishItems();

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
      itemCount: filteredWishItems.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FriendItemDetailed(wishItem: filteredWishItems[index], friendID: friendID,),
            ),
          );
        },
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Image.network(
                    filteredWishItems[index].image,
                    fit: BoxFit.contain,
                    width: 110,
                    height: 110,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${filteredWishItems[index].itemName}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                    Opacity(
                      opacity: 0.6,
                      child: Container(
                        height: 20,
                        width: (MediaQuery.of(ctx).size.width - 245) *
                            (filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${(filteredWishItems[index].fundAmount / filteredWishItems[index].itemPrice * 100).toStringAsFixed(2)}%',
                        style: TextStyle(color: Colors.black),
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

  List<WishItem> _filterWishItems() {
    return wishItems
        .where((item) =>
        item.itemName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
