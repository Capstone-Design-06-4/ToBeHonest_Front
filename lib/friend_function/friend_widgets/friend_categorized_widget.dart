// 파일명: header_row_widget.dart
import 'package:flutter/material.dart';

class FriendCategorized extends StatelessWidget {
  final String title;

  const FriendCategorized({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 135),
          Text(
            'GIVE',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 20.0),
          Text(
            'TAKE',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
