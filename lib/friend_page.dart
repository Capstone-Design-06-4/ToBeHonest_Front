import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildHeaderRow(String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.grey),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('GIVE', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 20.0),
              Text('TAKE', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 60.0),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFriendContainer(String name,String date) {
  return Container(
    height: 60.0,
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30.0,
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Icon(FontAwesomeIcons.gift),
            SizedBox(width: 30.0),
            Icon(FontAwesomeIcons.gift),
            SizedBox(width: 30.0),
            Icon(Icons.arrow_forward_ios, size: 25.0, color: Colors.grey),
          ],
        ),
      ],
    ),
  );
}

class FriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextField(
            style: TextStyle(fontSize: 14),  // 텍스트 크기 조절
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),  // 여기서 높이를 조절합니다.
              prefixIcon: Icon(Icons.search, size: 30),  // 아이콘 크기 조절
              hintText: '친구 이름  검색하기',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
        ),

        Container(
          height: 70.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0), // 원하는 모서리 둥근 정도를 지정
            boxShadow: [ // 선택적: 그림자 효과 추가
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
        ),

        Column(
          children: [
            buildHeaderRow('생일 디데이'),
          ],
        ),

        Column(
          children: [
            buildFriendContainer('Emily', 'D-Day 0월 0일'),
            buildFriendContainer('Brian', 'D-1'),
            buildFriendContainer('Nick', 'D-3'),
          ],
        ),

        Column(
          children: [
            buildHeaderRow('즐겨찾기'),
          ],
        ),

        Column(
          children: [
            buildFriendContainer('Emily', 'D-Day 0월 0일'),
            buildFriendContainer('Brian', 'D-1'),
            buildFriendContainer('Nick', 'D-3'),
          ],
        ),

        Column(
          children: [
            buildHeaderRow('친구'),
          ],
        ),

        Column(
          children: [
            buildFriendContainer('Emily', 'D-Day 0월 0일'),
            buildFriendContainer('Brian', 'D-1'),
            buildFriendContainer('Nick', 'D-3'),
          ],
        ),

      ],
    );
  }
}