import 'package:flutter/material.dart';
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
            backgroundColor: Colors.orange,
            title: Text('친구 추가하기'),
            centerTitle: true, // This ensures the title is centered
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              labelColor: Colors.white, // 탭의 텍스트 색상
              tabs: [
                Tab(
                  child: Text(
                    '전화번호',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // 굵게(bold) 설정
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    '이메일',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // 굵게(bold) 설정
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
