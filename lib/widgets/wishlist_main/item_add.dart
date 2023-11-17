import 'package:flutter/material.dart';
import '../wishlist_main/item_search.dart';

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
