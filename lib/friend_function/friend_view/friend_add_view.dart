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
            automaticallyImplyLeading: false,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 20), // Adjust the top and left margins as needed
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: AppColor.backgroundColor,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.0), // Adjust the preferredSize as needed
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0), // Adjust the top padding as needed
                child: TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        '전화번호',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
