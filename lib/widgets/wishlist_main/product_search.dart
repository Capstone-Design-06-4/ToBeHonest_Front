import 'package:flutter/material.dart';

class ProductSearchWidget extends StatefulWidget {
  final ValueChanged<String> onSearch;

  ProductSearchWidget({this.onSearch = _defaultOnSearch});

  static void _defaultOnSearch(String value) {}

  @override
  _ProductSearchWidgetState createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ProductSearchWidget> {
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
        onSubmitted: (value) => _handleSearch(),// 키보드에서 검색 버튼을 눌렀을 때
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(Icons.search, size: 30),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _controller.clear(),
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
