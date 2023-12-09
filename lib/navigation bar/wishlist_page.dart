import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_search_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_list_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_widgets/wishlist_main/item_add_button_widget.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';
import 'package:tobehonest/models/wishItem.dart';

enum SortOption {
  lowToHigh,
  highToLow,
}

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  String _searchText = '';
  final WishListController wishListController = Get.put(WishListController());
  final ScrollController _scrollController = ScrollController();
  SortOption _sortOption = SortOption.lowToHigh;

  Future<void> _onSearch(String text) async {
    setState(() {
      _searchText = text;
    });
    await _update();
  }

  Future<void> _update() async {
    try {
      await wishListController.fetchProgressWishItems_Con(searchText: _searchText);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  void _scrollToTop() {
    setState(() {
      _scrollController.jumpTo(0);
    });
  }

  void _toggleSort() {
    setState(() {
      _sortOption = (_sortOption == SortOption.lowToHigh)
          ? SortOption.highToLow
          : SortOption.lowToHigh;
    });
    _update();
  }

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor.withOpacity(0.8),
            title: Text(' \n위시리스트', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23, color: Colors.white)),
            actions: [
              Container(
                margin: EdgeInsets.only(top: 25, right: 20),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.sort),
                  onPressed: () {
                    _toggleSort();
                  },
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: AppColor.backgroundColor.withAlpha(200),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      ItemSearchBar(onSearch: _onSearch),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
              ItemAddBar(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('펀딩률: '),
                  DropdownButton<SortOption>(
                    value: _sortOption,
                    onChanged: (SortOption? value) {
                      setState(() {
                        _sortOption = value!;
                        _update();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: SortOption.lowToHigh,
                        child: Text('높은 순', style: TextStyle(fontSize: 14)),
                      ),
                      DropdownMenuItem(
                        value: SortOption.highToLow,
                        child: Text('낮은 순', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  SizedBox(width: 25,),
                ],
              ),

              Obx(() {
                if (wishListController.isLoading.isTrue) {
                  return Center(child: CircularProgressIndicator());
                } else if (wishListController.wishItems.length == 0) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      '상품이 없어요.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  );
                }
                // 펀딩액을 기준으로 정렬하여 WishItemList를 생성
                List<WishItem> sortedWishItems = _sortWishItems(wishListController.wishItems, _sortOption);
                return WishItemList(
                  wishItems: sortedWishItems,
                  searchText: _searchText,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

List<WishItem> _sortWishItems(List<WishItem> items, SortOption sortOption) {
  items.sort((a, b) {
    double percentageA = a.fundAmount / a.itemPrice;
    double percentageB = b.fundAmount / b.itemPrice;

    if (sortOption == SortOption.highToLow) {
      return percentageA.compareTo(percentageB);
    } else {
      return percentageB.compareTo(percentageA);
    }
  });

  return items;
}
