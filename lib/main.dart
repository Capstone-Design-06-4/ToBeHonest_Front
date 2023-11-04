import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/friend.dart';

import '../services/login_service.dart';
import '../services/friend_service.dart';

import 'friend_page.dart';
import 'giftbox_page.dart';
import 'memorybox_page.dart';

import 'myprofile_page.dart';
import 'wishlist_page.dart';
import 'navigation_bar.dart';


//main에서 처리하는 것이 아닌 추가 수정 필요
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 바인딩을 초기화합니다.
  await Hive.initFlutter(); // Hive를 초기화합니다.
  // Hive 어댑터를 등록합니다.
  Hive.registerAdapter(FriendAdapter());
  await login('이메일 자리', '비밀번호 자리');
  String? token = await getToken();
  if (token != null) {
    await fetchFriends(token);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    FriendPage(), // 친구 페이지
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
      bottomNavigationBar: BottomNav(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
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