import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      height: 70.0,
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFF4A261),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '친구'),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.t), label: '위시리스트'),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.b), label: '선물함'),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.h), label: '기억함'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
          ],
        ),
      ),
    );
  }
}
