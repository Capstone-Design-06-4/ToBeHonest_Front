import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemStatusWidget extends StatelessWidget {
  final int progressNum;
  final int completedNum;
  final int usedNoMsgNum;
  final int usedMsgNum;

  ItemStatusWidget({
    Key? key,
    required this.progressNum,
    required this.completedNum,
    required this.usedNoMsgNum,
    required this.usedMsgNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(
            icon: FontAwesomeIcons.gift,
            backgroundColor: Colors.yellow,
            title: '위시리스트',
            count: progressNum,
            onTap: () => print('위시리스트'),
          ),
          _buildItem(
            icon: FontAwesomeIcons.qrcode,
            backgroundColor: Colors.blue,
            title: '선물함',
            count: completedNum,
            onTap: () => print('선물함'),
          ),
          _buildItem(
            icon: FontAwesomeIcons.star,
            backgroundColor: Colors.green,
            title: '기억함',
            count: usedMsgNum + usedNoMsgNum,
            onTap: () => print('기억함'),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required Color backgroundColor,
    required String title,
    required int count,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '${count}개',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
