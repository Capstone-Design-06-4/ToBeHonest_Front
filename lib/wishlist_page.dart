import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/wishlist_main/item_search.dart';
import 'widgets/wishlist_main/item_list.dart';
import 'widgets/wishlist_main/item_add.dart';

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
    return Column(
      children: <Widget>[
        ItemSearchBar(onSearch: _onSearch),
        Expanded(
          child: ListView(
            children: <Widget>[
              ItemAddBar(context),
              ItemList(),
            ],
          ),
        ),
      ],
    );
  }
}

