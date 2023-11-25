//item_list.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_detailed_view.dart';
import 'package:tobehonest/models/wishItem.dart';

class WishItemList extends StatefulWidget {
  final List<WishItem> wishItems;
  final String searchText;

  WishItemList({required this.wishItems, required this.searchText});

  @override
  State<WishItemList> createState() => _WishItemListState();
}

class _WishItemListState extends State<WishItemList> {
  @override
  Widget build(BuildContext context) {
    List<WishItem> filteredWishItems = _filterWishItems();

    return GridView.builder(
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailed(wishItem: filteredWishItems[index]),
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
    return widget.wishItems
        .where((item) =>
        item.itemName.toLowerCase().contains(widget.searchText.toLowerCase()))
        .toList();
  }
}
