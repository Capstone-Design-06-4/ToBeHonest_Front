// item_search.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';

class ItemSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  ItemSearchBar({required this.onSearch});

  @override
  _ProductSearchWidgetState createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ItemSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    widget.onSearch(_controller.text);
  }

  @override
  void initState() {
    super.initState();

    // initState에서 컨트롤러 초기화
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD3D3D3);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: TextField(
        controller: _controller,
        onChanged: (value) => widget.onSearch(value),
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(Icons.search, size: 25),
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
            borderSide: BorderSide(color: borderColor, width: 1.0), // 연한 회색 테두리 적용
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: borderColor, width: 1.0), // 연한 회색 테두리 적용
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
