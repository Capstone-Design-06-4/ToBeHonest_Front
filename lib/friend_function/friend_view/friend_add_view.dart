import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'friend_add/friend_add_tel_page.dart';
import 'friend_add/friend_add_email_page.dart';

class AddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.backgroundColor,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('친구 추가하기', style: TextStyle(color: Colors.white)),
            bottom: TabBar(
              labelColor: Colors.white, // 탭의 텍스트 색상
              tabs: [
                Tab(
                  child: Text(
                    '전화번호',
                    style: TextStyle(
                      fontSize: 16, // 굵게(bold) 설정
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    '이메일',
                    style: TextStyle(
                      fontSize: 16, // 굵게(bold) 설정
                    ),
                  ),
                ),
              ],
            ),

          ),
          body: TabBarView(
            children: [
              PhoneNumberAddPage(),
              EmailAddPage(),
            ],
          ),
        ),
      ),
    );
  }
}
