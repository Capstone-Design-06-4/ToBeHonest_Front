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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MyInfoController myInfoController = Get.put(MyInfoController());

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
                  Obx(() => PointWidget(onTap: () => print('포인트'), point: myInfoController.myInfo.value.myPoints)),
                  SizedBox(height: 8),
                  Obx(() => ItemStatusWidget(
                    progressNum: myInfoController.myInfo.value.progressNum,
                    completedNum: myInfoController.myInfo.value.completedNum,
                    usedNoMsgNum: myInfoController.myInfo.value.usedNoMsgNum,
                    usedMsgNum: myInfoController.myInfo.value.usedMsgNum,
                  )),
                  SizedBox(height: 8),
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
