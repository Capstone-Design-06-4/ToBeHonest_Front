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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 50,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              bottom: TabBar(
                labelColor: Colors.white, // 탭의 텍스트 색상
                tabs: [
                  Tab(
                    child: Text(
                      '전화번호',
                      style: TextStyle(
                          fontSize: 20, color: AppColor.objectColor// 굵게(bold) 설정
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '이메일',
                      style: TextStyle(
                          fontSize: 20, color: AppColor.objectColor// 굵게(bold) 설정
                      ),
                    ),
                  ),
                ],
              ),
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
