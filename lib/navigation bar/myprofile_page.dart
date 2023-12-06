// friend_page.dart

import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tobehonest/myInfo_UI/profile_widget.dart';
import 'package:tobehonest/myInfo_UI/point_widget.dart';
import 'package:tobehonest/myInfo_UI/itemStatus_widget.dart';
import 'package:tobehonest/myInfo_UI/history_widget.dart';
import 'package:tobehonest/controllers/myInfo_controller.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tobehonest/services/url_manager.dart';
import 'package:tobehonest/services/point_service.dart';
import 'package:tobehonest/services/login_service.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MyInfoController myInfoController = Get.put(MyInfoController());

  Future<void> _update() async {
    try {
      await myInfoController.fetchMyInfo();
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  Future<void> logout() async {
    try {
      // 사용자 관련 정보 모두 삭제
      await removeToken();
      await removeEmail();
      await removeID();
      await removeProfileImg();

      print('로그아웃 성공');
      Get.offAllNamed('/login');
      Get.snackbar(
        '알림',
        '로그아웃되었습니다.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('로그아웃 실패: $e');
    }
  }

  Future<void> removeID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ID');
  }

  Future<void> removeProfileImg() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ProfileImg');
  }

  Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD3D3D3);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor,
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: AppColor.backgroundColor.withAlpha(200),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45.0, // 원형 이미지의 가로 크기
                          height: 45.0, // 원형 이미지의 세로 크기
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // 원형 모양 지정
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'), // 이미지 경로 지정
                              fit: BoxFit.fill, // 이미지가 컨테이너를 완전히 채우도록 설정
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('MY', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height:20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,  // 배경색 설정
                        borderRadius: BorderRadius.circular(12.0),  // 둥근 모서리 설정
                      ),
                      padding: EdgeInsets.all(8.0),  // 내부 여백 설정
                      child: Text(
                        '오늘도 선물같은 하루되세요!',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),  // 텍스트 스타일 설정
                      ),
                    ),
                    SizedBox(height:15),
                  ],
                ),
              ),
            ),
            SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() => ProfileWidget(
                      profileURL: myInfoController.myInfo.value.profileURL,
                      name: myInfoController.myInfo.value.name,
                      birthDate: myInfoController.myInfo.value.birthDate),
                  ),
                  SizedBox(height: 8),
                  Obx(() => PointWidget(
                      onTap: () async {
                        print('포인트 추가해볼게');
                        String? token = await getToken() ?? '0';
                        await addPoint(1234, token);
                        myInfoController.fetchMyInfo();
                      },
                      point: myInfoController.myInfo.value.myPoints)),
                  SizedBox(height: 8),
                  Obx(() => ItemStatusWidget(
                    progressNum: myInfoController.myInfo.value.progressNum,
                    completedNum: myInfoController.myInfo.value.completedNum,
                    usedNoMsgNum: myInfoController.myInfo.value.usedNoMsgNum,
                    usedMsgNum: myInfoController.myInfo.value.usedMsgNum,
                  )),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print('로그아웃 버튼 클릭됨');

                                      await logout();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColor.backgroundColor,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize: Size(0, 36),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      '로그아웃하기',
                                      style: TextStyle(fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //HistoryWidget(),
          ],
        ),
      ),
    );
  }
}
