// 파일명: header_row_widget.dart
import 'package:flutter/material.dart';

class FriendCategorized extends StatelessWidget {
  final String title;

  const FriendCategorized({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),

          ],
        ),
      ),
    );
  }
}
