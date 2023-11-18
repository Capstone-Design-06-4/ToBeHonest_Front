//friend_add_detailed.dart

import 'package:flutter/material.dart';
import 'friend_add/friend_add_tel_page.dart';
import 'friend_add/friend_add_email_page.dart';

class AddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('친구 추가하기'),
          centerTitle: true, // This ensures the title is centered
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: '전화번호'), // Labeled tab for phone number
              Tab(text: '이메일'),    // Labeled tab for email
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
    );
  }
}
