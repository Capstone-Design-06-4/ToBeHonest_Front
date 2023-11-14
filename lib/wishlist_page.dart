import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/widgets/wishlist_main/product_search.dart';
import 'widgets/wishlist_main/product_list.dart';

class Wishlist_Page extends StatefulWidget {
  @override
  _Wishlist_PageState createState() => _Wishlist_PageState();
}

class _Wishlist_PageState extends State<Wishlist_Page> {
  String _searchText = '';

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ProductSearchWidget(onSearch: _onSearch),
        buildSearchBar(context),
        ProductGridView(),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewProductPage(),
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
}

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String _searchText = "";

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("새로운 상품 추가하기"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            ProductSearchWidget(onSearch: _onSearch),
            Expanded(
              child: Center(
                child: Text("검색된 상품: $_searchText"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

