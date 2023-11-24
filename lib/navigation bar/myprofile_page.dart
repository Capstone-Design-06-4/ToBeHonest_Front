// friend_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/friend_search_controller.dart';
import '../friend_function/friend_widgets/friend_list_widget.dart';
import '../friend_function/friend_widgets/friend_search_widget.dart';
import '../friend_function/friend_widgets/friend_add_click.dart';
import '../friend_function/friend_widgets/friend_categorized_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD3D3D3);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.objectColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.objectColor,
            title: Text(
              '마이페이지',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColor.textColor,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
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
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 변경된 부분
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('오늘도 선물같은 하루 되세요!', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          Text('와사비 님', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          Text('생년월일', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60,
                          child: Icon(Icons.person_add, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // 터치 이벤트 처리
                // 예: 아이콘을 터치하면 어떤 동작을 수행하도록 설정
              },
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
                                FontAwesomeIcons.p,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '보유 포인트: 100,000 원',
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
            ),

            Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 열 간의 간격을 균등하게 조절
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // 첫 번째 컨테이너를 탭했을 때 수행되는 동작 추가
                        print('1');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 내용을 세로로 가운데 정렬
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow, // 배경색 설정
                            radius: 35, // 반지름 설정
                            child: Icon(
                              FontAwesomeIcons.gift, // P 아이콘
                              size: 40,
                              color: Colors.white, // 아이콘 색상
                            ),
                          ),
                          SizedBox(height: 10), // 간격 조절
                          Text(
                            '위시리스트',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5), // 간격 조절
                          Text(
                            '10개',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // 첫 번째 컨테이너를 탭했을 때 수행되는 동작 추가
                        print('1');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 35, // 반지름 설정
                            child: Icon(
                              FontAwesomeIcons.qrcode,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10), // 간격 조절
                          Text(
                            '선물함',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5), // 간격 조절
                          Text(
                            '10개',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // 첫 번째 컨테이너를 탭했을 때 수행되는 동작 추가
                        print('1');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 35, // 반지름 설정
                            child: Icon(
                              FontAwesomeIcons.star,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10), // 간격 조절
                          Text(
                            '기억함',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5), // 간격 조절
                          Text(
                            '10개',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // 첫 번째 컨테이너를 탭했을 때 수행되는 동작 추가
                      print('포인트 사용내역 탭!');
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 16.0, right: 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              '포인트 사용내역',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // 두 번째 컨테이너를 탭했을 때 수행되는 동작 추가
                      print('펀딩 참여내역 탭!');
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 16.0, left: 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              '펀딩 참여내역',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),

      ),
    );
  }
}
