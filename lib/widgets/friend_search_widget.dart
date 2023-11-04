// 파일명: search_friend_widget.dart
import 'package:flutter/material.dart';

class SearchFriendWidget extends StatelessWidget {
  const SearchFriendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        style: const TextStyle(fontSize: 14),  // 텍스트 크기 조절
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),  // 여기서 높이를 조절합니다.
          prefixIcon: const Icon(Icons.search, size: 30),  // 아이콘 크기 조절
          hintText: '친구 이름 검색하기',
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
