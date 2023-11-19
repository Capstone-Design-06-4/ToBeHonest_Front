import 'package:flutter/material.dart';
import 'package:tobehonest/wishlist_widget/wishlist_main/item_search_widget.dart';

class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
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
            ItemSearchBar(onSearch: _onSearch),
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
