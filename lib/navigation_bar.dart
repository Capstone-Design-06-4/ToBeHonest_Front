import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';

class BottomNav extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;

  BottomNav({required this.onTap, required this.currentIndex});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFfbfbf2),
          selectedItemColor: AppColor.swatchColor,
          unselectedItemColor: Colors.black12,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          selectedLabelStyle: TextStyle(fontSize: 16.0), // 선택된 아이템의 글씨 크기
          unselectedLabelStyle: TextStyle(fontSize: 14.0), // 선택되지 않은 아이템의 글씨 크기
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people,),
              label: '친구',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.t,),
              label: '위시리스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.b,),
              label: '선물함',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.h,),
              label: '기억함',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label: 'MY',
            ),

          ],
        ),
      ),
    );
  }
}
