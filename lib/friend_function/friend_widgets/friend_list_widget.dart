import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:tobehonest/friend_function/friend_view/friend_detailed_view.dart';
import 'package:tobehonest/friend_function/friend_view/friend_wishlist_view.dart'; // Import the necessary file
import 'package:tobehonest/friend_function/friend_view/friend_memory_page/friend_memory_page.dart';

Widget buildFriendContainer(BuildContext context, Friend friend) {
  return Padding(
    padding: const EdgeInsets.only(right: 16,left: 16),
    child: GestureDetector(
      onTap: () {
        ModalUtils.showFriendModal(context, friend);
      },
      child: Column(
        children: [
          Container(
            height: 70.0,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
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
                      backgroundImage: NetworkImage(friend.profileURL),
                      radius: 30.0,
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        buildBirthdayText(friend.birthDate),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(
                          friend.myGive ? FontAwesomeIcons.smile : FontAwesomeIcons.gift,
                          color: friend.myGive ? AppColor.swatchColor : Colors.grey,
                        ),
                        SizedBox(height: 5,),
                        Text("GIVE"),
                      ],
                    ),
                    const SizedBox(width: 30.0),
                    Column(
                      children: [
                        Icon(
                          friend.myTake ? FontAwesomeIcons.smile : FontAwesomeIcons.gift,
                          color: friend.myTake ? AppColor.swatchColor : Colors.grey,
                        ),
                        SizedBox(height: 5,),
                        Text("TAKE"),
                      ],
                    ),
                    const SizedBox(width: 35.0),
                    const Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.grey),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5,)
        ],
      ),
    ),
  );
}

class ModalUtils {
  static void showFriendModal(BuildContext context, Friend friend) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 260, // 모달 높이 크기
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 100,
          ), // 모달 좌우하단 여백 크기
          decoration: BoxDecoration(
            color: Colors.white, // 모달 배경색
            borderRadius: BorderRadius.all(
              Radius.circular(20), // 모달 전체 라운딩 처리
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 5,),
              Container(
                height: 70.0,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColor.swatchColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(friend.profileURL), // Provide the friend's profile image URL
                            radius: 60.0,
                          ),
                        ),
                        SizedBox(width: 16.0), // Adjust the spacing between CircleAvatar and Text widgets
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              friend.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            buildBirthdayText(friend.birthDate), // 수정된 부분
                          ],
                        ),
                        SizedBox(width: 30,),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Icon(
                                  friend.myGive ? FontAwesomeIcons.check : FontAwesomeIcons.gift,
                                  color: friend.myGive ? Colors.green : Colors.grey,
                                ),
                                SizedBox(height: 5,),
                                Text(" GIVE"),
                              ],
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Icon(
                                  friend.myTake ? FontAwesomeIcons.check : FontAwesomeIcons.gift,
                                  color: friend.myTake ? Colors.green : Colors.grey,
                                ),
                                SizedBox(height: 5,),
                                Text(" TAKE"),
                              ],
                            ),
                          ],
                        ),
                        Spacer(), // Add this to provide space between text and trailing icon
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear, // You can change this to any other icon
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendWishlistPage(friendName: friend.name, friendID: friend.id),
                      ));
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundColor: AppColor.swatchColor,
                        child: Icon(Icons.card_giftcard, color: Colors.white),
                      ),
                      title: Text('위시리스트 보기'),
                      subtitle: Text('펀딩에 참여해요!'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendMemoryPage(friendName: friend.name, friendID: friend.id),
                      ));
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundColor: AppColor.swatchColor,
                        child: Icon(Icons.emoji_emotions, color: Colors.white),
                      ),
                      title: Text('추억함 보기'),
                      subtitle: Text('주고받은 추억을 되새겨요!'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
        backgroundColor: Colors.transparent
    );
  }
}

Widget buildBirthdayText(String birthDateString) {
  // 생일 문자열을 DateTime 객체로 파싱
  DateTime birthDate = DateTime.parse(birthDateString);

  // 월과 일을 추출
  int month = birthDate.month;
  int day = birthDate.day;

  // 최종적으로 텍스트로 표시할 문자열 생성
  String displayText = '$month월 $day일';

  return Text(
    displayText,
    style: const TextStyle(fontSize: 14.0, color: Colors.black),
  );
}