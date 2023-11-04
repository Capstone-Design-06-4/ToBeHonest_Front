import 'package:flutter/material.dart';
import '../models/friend.dart'; // Friend 모델을 위한 임포트, 실제 경로로 변경해야 함

class FriendDetailPage extends StatelessWidget {
  final Friend friend;

  const FriendDetailPage({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.white), // 전체 배경을 하얀색으로 설정합니다.
          Positioned(
            top: 40.0,
            left: 10.0,
            child: IconButton(
              icon: Icon(Icons.close, size: 30.0), // 닫기 버튼
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black, // 배경색을 하얀색으로 설정
                  backgroundImage: NetworkImage(friend.profileURL), // 프로필 이미지
                  radius: 60.0, // 원하는 크기로 조절
                ),
                SizedBox(height: 10.0),
                Text(
                  friend.name, // 친구의 이름
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.star_border, color: Colors.yellow[700]), // 위시리스트 버튼
                      iconSize: 40.0, // 아이콘 크기 조절
                      onPressed: () {
                        // 위시리스트 기능 구현
                      },
                    ),
                    SizedBox(width: 40),
                    IconButton(
                      icon: Icon(Icons.bookmark_border, color: Colors.teal), // 추억함 버튼
                      iconSize: 40.0, // 아이콘 크기 조절
                      onPressed: () {
                        // 추억함 기능 구현
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
