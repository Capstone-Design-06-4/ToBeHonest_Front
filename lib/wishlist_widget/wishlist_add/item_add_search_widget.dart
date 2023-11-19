// item_add_search_widget.dart

import 'package:flutter/material.dart';

class ItemAddSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  ItemAddSearchBar({required this.onSearch});

  @override
  _ItemAddSearchWidgetState createState() => _ItemAddSearchWidgetState();
}

class _ItemAddSearchWidgetState extends State<ItemAddSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    widget.onSearch(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: _controller,
        onSubmitted: (_) => _handleSearch(),  // 검색 버튼 눌렀을 때 호출
        onChanged: (value) => widget.onSearch(value),
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(Icons.search, size: 30),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              widget.onSearch('');
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