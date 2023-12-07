import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tobehonest/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import 'models/friend.dart';
import 'models/item.dart';
import 'models/wishItem.dart';
import 'models/contributor.dart';

import '../services/login_service.dart';
import '../services/friend_service.dart';
import '../services/item_service.dart';
import '../services/wishlist_service.dart';

import '../controllers/friend_search_controller.dart';
import '../controllers/friend_add_controller.dart';

import 'navigation bar/friend_page.dart';
import 'navigation bar/giftbox_page.dart';
import 'navigation bar/memorybox_page.dart';
import 'navigation bar/myprofile_page.dart';
import 'navigation bar/wishlist_page.dart';
import 'thanks_message/thanks_message_view.dart';
import 'navigation_bar.dart';
import 'login_page/login.dart';
import 'package:tobehonest/controllers/friend_search_controller.dart';
import 'package:tobehonest/controllers/giftbox_controller.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:tobehonest/controllers/usedbox_controller.dart';
import 'package:tobehonest/controllers/myInfo_controller.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FriendAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(WishItemAdapter());
  Hive.registerAdapter(ContributorAdapter());
  KakaoSdk.init(nativeAppKey: '07150a42df86d834d5deb4c2cffbb9e9');

  // 로그인을 시도하고 토큰이 있으면 친구 목록을 가져옵니다

  //await login('email1@example.com', 'password1');

  //await login('email1@example.com', 'password1');

  //final String? token = await getToken();
  //if (token != null) {
  //  await fetchFriends(token);
  //  await friendController.getFriendsList(); // fetchFriends 메서드 호출
  //}
  // 앱 실행
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'AppleSDGothicNeo',
        primaryColor: AppColor.swatchColor,
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          color: AppColor.backgroundColor,
        ),
        scaffoldBackgroundColor: Color(0xFFfbfbf2),
      ),
      initialRoute: '/login', // Set the initial route to '/login'
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => MyHomePage()),
        // Add more routes as needed
      ],
    );
  }
}




class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final appBarTitles = ['친구', '위시리스트', '선물함', '기억함', 'MY'];

  final _pages = [
    FriendPage(), // 친구 페이지
    WishListPage(), // 위시리스트 페이지
    GiftBoxPage(), // 선물함 페이지
    MemoryBoxPage(), // 기억함 페이지
    ProfilePage(), // MY 페이지
  ];

  final FriendController friendController = Get.put(FriendController());
  final WishListController wishListController = Get.put(WishListController());
  final GiftBoxController giftBoxController = Get.put(GiftBoxController());
  final MemoryBoxController memoryBoxController = Get.put(MemoryBoxController());
  final ThankBoxController thankBoxController = Get.put(ThankBoxController());
  final MyInfoController myInfoController = Get.put(MyInfoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFF4A261),
            title: Text(appBarTitles[_currentIndex], style: TextStyle(fontWeight: FontWeight.normal)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNav(
          onTap: (index) async {
            setState(() {
              _currentIndex = index;
            });
            switch(_currentIndex) {
              case 0:
                await friendController.getFriendsList();
                break;
              case 1:
                await wishListController.fetchProgressWishItems_Con();
                break;
              case 2:
                await giftBoxController.fetchCompleteWishItems_Con();
                break;
              case 3:
                await memoryBoxController.fetchUsedWishItems_Con();
                await thankBoxController.fetchThnakWishItems_Con();
                break;
              case 4:
                await myInfoController.fetchMyInfo();
                break;
            }
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}