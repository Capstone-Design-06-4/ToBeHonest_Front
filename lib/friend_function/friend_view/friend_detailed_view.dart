import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:tobehonest/friend_function/friend_view/friend_wishlist_view.dart';

class FriendDetailPage extends StatelessWidget {
  final Friend friend;

  const FriendDetailPage({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Container(
                    child: Text(
                      friend.name, // 친구의 이름
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      friend.birthDate,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Give', // 친구의 이름
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Icon(
                            friend.myGive ? FontAwesomeIcons.gift : FontAwesomeIcons.gifts,
                            color: friend.myGive ? Colors.red : Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(width: 40.0,),
                      Column(
                        children: [
                          Text(
                            'Take', // 친구의 이름
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Icon(
                            friend.myTake ? FontAwesomeIcons.gift : FontAwesomeIcons.gifts,
                            color: friend.myTake ? Colors.green : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10), // 마진 설정
                            child: ElevatedButton(
                              onPressed: () {
                                // 버튼이 눌렸을 때 수행할 동작 구현
                                print('위시리스트 버튼이 눌렸습니다.');
                                // FriendWishlistPage로 네비게이션
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FriendWishlistPage(friendID: friend.id),
                                  ),
                                );
                                // 여기에 위시리스트 관련 동작을 추가하세요.
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0), // 원하는 모양의 모서리 설정
                                ),
                                primary: Colors.orange[300], // 배경색 설정
                                elevation: 5.0, // 그림자 설정
                                padding: const EdgeInsets.all(20.0), // 패딩 설정
                              ),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      friend.name + '의',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text(
                                      '위시리스트 목록 보기',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10), // 마진 설정
                            child: ElevatedButton(
                              onPressed: () {
                                // 버튼이 눌렸을 때 수행할 동작 구현
                                print('위시리스트 버튼이 눌렸습니다.');
                                // 여기에 위시리스트 관련 동작을 추가하세요.
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0), // 원하는 모양의 모서리 설정
                                ),
                                primary: Colors.orange[300], // 배경색 설정
                                elevation: 5.0, // 그림자 설정
                                padding: const EdgeInsets.all(20.0), // 패딩 설정
                              ),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      friend.name + '의',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text(
                                      '추억함 열어보기',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
