// search_friend_widget.dart

import 'package:flutter/material.dart';

class SearchFriendWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchFriendWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 연한 회색 테두리 색상을 정의합니다.
    const borderColor = Color(0xFFD3D3D3);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(Icons.search, size: 30),
          hintText: '친구 이름 검색하기',
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
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => controller.clear(),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}