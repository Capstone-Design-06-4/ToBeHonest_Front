import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileWidget extends StatelessWidget {
  final String profileURL;
  final String name;
  final DateTime birthDate;
  final String greetingMessage = "오늘도 선물같은 하루 되세요!";

  ProfileWidget({
    Key? key,
    required this.profileURL,
    required this.name,
    required this.birthDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text(greetingMessage, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(DateFormat('yyyy / MM / dd').format(birthDate), style: TextStyle(fontSize: 18)),

                ],
              ),
            ),
            SizedBox(width: 0,),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(profileURL),
              onBackgroundImageError: (exception, stackTrace) {
                child: CircularProgressIndicator();// 이미지 로딩 중 표시할 위젯
                // 이미지 로드 실패 시 처리
              },
            ),
            SizedBox(width: 0,),
          ],
        ),
      ),
    );
  }
}
