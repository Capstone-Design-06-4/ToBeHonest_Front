import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'friend_page.dart';
import 'giftbox_page.dart';
import 'memorybox_page.dart';
import 'myprofile_page.dart';
import 'wishlist_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'AppleSDGothicNeo',
        primaryColor: Color(0xFFF4A261),
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final appBarTitles = [
    '친구',
    '위시리스트',
    '선물함',
    '기억함',
    'MY'
  ];

  final _pages = [
    PlaceholderWidget(Colors.red),
    PlaceholderWidget(Colors.blue), // 위시리스트 페이지
    PlaceholderWidget(Colors.green), // 선물함 페이지
    PlaceholderWidget(Colors.yellow), // 기억함 페이지
    PlaceholderWidget(Colors.purple), // MY 페이지
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4A261),
        title: Text(appBarTitles[_currentIndex], style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
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
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.people), label: '친구'),
              BottomNavigationBarItem(icon: Icon(Icons.circle), label: '위시리스트'),
              BottomNavigationBarItem(icon: Icon(Icons.circle), label: '선물함'),
              BottomNavigationBarItem(icon: Icon(Icons.circle), label: '기억함'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}