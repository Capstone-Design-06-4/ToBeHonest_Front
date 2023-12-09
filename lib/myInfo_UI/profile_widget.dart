import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/style.dart';

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
      height: 140,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.userCheck,  // You can choose any FontAwesome icon
                      color: AppColor.textColor,
                      size: 20,  // Adjust the size as needed
                    ),
                    SizedBox(width: 8),  // Adjust the spacing between the icon and the text
                    Text(
                      " 내 정보",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textColor),
                    ),
                  ],
                ),

                SizedBox(height: 5),
                //Text(greetingMessage, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                Text(DateFormat('MM월 dd일').format(birthDate), style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(width: 0,),
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(profileURL),
            onBackgroundImageError: (exception, stackTrace) {
              child: CircularProgressIndicator();// 이미지 로딩 중 표시할 위젯
              // 이미지 로드 실패 시 처리
            },
          ),
          SizedBox(width: 0,),
        ],
      ),
    );
  }
}
