import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FriendPage(),
    );
  }
}

class FriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 목록'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              // 친구 추가하기 버튼을 눌렀을 때 전화번호로 추가하기 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneNumberAddPage()),
              );
            },
            child: AddFriendTile(),
          ),
          // 친구 목록 및 기타 내용 추가
        ],
      ),
    );
  }
}

class AddFriendTile extends StatelessWidget {
  const AddFriendTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person_add, color: Colors.white),
        ),
        title: Text('친구 추가하기'),
        subtitle: Text('소중한 사람들과 함께해요!'),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
      ),
    );
  }
}

class PhoneNumberAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전화번호로 추가하기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('전화번호로 친구를 추가하는 페이지입니다.'),
            // 입력 필드 및 추가 로직 구현
          ],
        ),
      ),
    );
  }
}

class EmailAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이메일로 추가하기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('이메일로 친구를 추가하는 페이지입니다.'),
            // 입력 필드 및 추가 로직 구현
          ],
        ),
      ),
    );
  }
}
