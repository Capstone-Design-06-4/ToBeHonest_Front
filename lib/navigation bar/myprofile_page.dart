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
            title: Text('MY', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          children: [
            Obx(() => ProfileWidget(
                profileURL: myInfoController.myInfo.value.profileURL,
                name: myInfoController.myInfo.value.name,
                birthDate: myInfoController.myInfo.value.birthDate),
            ),
            Obx(() => PointWidget(onTap: () => print('포인트'), point: myInfoController.myInfo.value.myPoints)),
            Obx(() => ItemStatusWidget(
              progressNum: myInfoController.myInfo.value.progressNum,
              completedNum: myInfoController.myInfo.value.completedNum,
              usedNoMsgNum: myInfoController.myInfo.value.usedNoMsgNum,
              usedMsgNum: myInfoController.myInfo.value.usedMsgNum,
            )),
            SizedBox(height: 8),
            HistoryWidget(),
          ],
        ),
      ),
    );
  }
}
