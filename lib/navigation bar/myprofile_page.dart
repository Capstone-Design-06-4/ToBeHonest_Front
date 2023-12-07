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
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // 아이콘을 감싸는 배경 색상 설정 (필요에 따라 변경)
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.homeUser, // "friend"에 해당하는 아이콘
                              size: 20.0, // 아이콘의 크기 설정
                              color: AppColor.swatchColor, // 아이콘의 색상 설정
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('MY', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white)),
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
                    SizedBox(height:20),
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
                  Obx(() => PointWidget(
                      onTap: () async {
                        print('포인트 추가해볼게');
                        String? token = await getToken() ?? '0';
                        await addPoint(1234, token);
                        myInfoController.fetchMyInfo();
                      },
                      point: myInfoController.myInfo.value.myPoints)),
                  Obx(() => ItemStatusWidget(
                    progressNum: myInfoController.myInfo.value.progressNum,
                    completedNum: myInfoController.myInfo.value.completedNum,
                    usedNoMsgNum: myInfoController.myInfo.value.usedNoMsgNum,
                    usedMsgNum: myInfoController.myInfo.value.usedMsgNum,
                  )),
                  SizedBox(height: 30),
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
                                    bool confirm = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("로그아웃 확인"),
                                          content: Text("정말로 로그아웃 하시겠습니까?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false); // Cancel logout
                                              },
                                              child: Text("취소"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true); // Confirm logout
                                              },
                                              child: Text("확인"),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (confirm == true) {
                                      // User confirmed, perform logout
                                      print('로그아웃 버튼 클릭됨');
                                      await logout();
                                    }
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
                                      style: TextStyle(fontSize: 18),
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
