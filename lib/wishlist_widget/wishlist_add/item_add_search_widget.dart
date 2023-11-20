// item_add_search_widget.dart

import 'package:flutter/material.dart';

class ItemAddSearchBar extends StatefulWidget {
  final ValueChanged<String> handleSearch;

  ItemAddSearchBar({required this.handleSearch});

  @override
  _ItemAddSearchWidgetState createState() => _ItemAddSearchWidgetState();
}

class _ItemAddSearchWidgetState extends State<ItemAddSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    widget.handleSearch(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: _controller,
        onSubmitted: (_) => _handleSearch(),
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(Icons.search, size: 30),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              widget.handleSearch('');
            },
          ),
          hintText: '상품 이름 검색하기',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}
