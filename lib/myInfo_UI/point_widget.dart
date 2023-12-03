import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointWidget extends StatelessWidget {
  final VoidCallback onTap;
  final int point; // 포인트를 위한 생성자 매개변수 추가

  PointWidget({Key? key, required this.onTap, required this.point}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 13,
                      child: Icon(
                        FontAwesomeIcons.p, // FontAwesome 아이콘
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '보유 포인트: ${point.toString()} 원', // 포인트를 표시
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.chevron_right, // ">" 아이콘
              size: 30,
              color: Colors.grey,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
