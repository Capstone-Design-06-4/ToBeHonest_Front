import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:tobehonest/friend_function/friend_view/friend_detailed_view.dart';
import 'package:tobehonest/friend_function/friend_view/friend_wishlist_view.dart'; // Import the necessary file
import 'package:tobehonest/friend_function/friend_view/friend_memory_page/friend_memory_page.dart';
import 'package:tobehonest/controllers/messagebox_controller.dart';
import 'package:get/get.dart';


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
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
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
                        buildBirthdayDdayText(friend.birthDate),
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
                          color: friend.myGive ? AppColor.swatchColor : Colors.grey[200],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "GIVE",
                          style: TextStyle(
                            color: friend.myGive ? Colors.black : Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30.0),
                    Column(
                      children: [
                        Icon(
                          friend.myTake ? FontAwesomeIcons.smile : FontAwesomeIcons.gift,
                          color: friend.myTake ? AppColor.swatchColor : Colors.grey[200],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "TAKE",
                          style: TextStyle(
                            color: friend.myTake ? Colors.black : Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 35.0),
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
    final MessageController messageController = Get.put(MessageController(friend.id));
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
                        Spacer(),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Icon(
                                  friend.myGive ? FontAwesomeIcons.smileWink : FontAwesomeIcons.gift,
                                  color: friend.myGive ? AppColor.swatchColor : Colors.grey[200],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "GIVE",
                                  style: TextStyle(
                                    color: friend.myGive ? Colors.black : Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Icon(
                                  friend.myTake ? FontAwesomeIcons.smileWink : FontAwesomeIcons.gift,
                                  color: friend.myTake ? AppColor.swatchColor : Colors.grey[200],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "TAKE",
                                  style: TextStyle(
                                    color: friend.myTake ? Colors.black : Colors.grey[200],
                                  ),
                                ),
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
                onTap: () async {
                  await messageController.setFriendIDAndRefresh(friend.id);
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
  String displayText = '생일: $month월 $day일';

  return Text(
    displayText,
    style: const TextStyle(fontSize: 13.0, color: Colors.black),
  );
}

Widget buildBirthdayDdayText(String birthDateString) {
  // 생일 문자열을 DateTime 객체로 파싱
  DateTime birthDate = DateTime.parse(birthDateString);

  // 현재 날짜 가져오기
  DateTime today = DateTime.now();

  // 생일의 연도를 현재 연도로 설정
  DateTime nextBirthday = DateTime(today.year, birthDate.month, birthDate.day);

  // 생일이 이미 지났으면 내년으로 설정
  if (nextBirthday.isBefore(today)) {
    nextBirthday = DateTime(today.year + 1, birthDate.month, birthDate.day);
  }

  // 생일까지 남은 일 수 계산
  int daysRemaining = nextBirthday.difference(today).inDays;

  // 최종적으로 텍스트로 표시할 문자열 생성
  String displayText = 'D-${daysRemaining}';

  // 아이콘 색상 조건에 따라 설정
  Color iconColor = daysRemaining <= 7 ? Colors.red : Colors.black12;

  return Row(
    children: [
      Text(
        displayText,
        style: TextStyle(fontSize: 13.0, color: Colors.black),
      ),
      SizedBox(width: 5.0),
      Icon(
        Icons.cake, // You can replace this with the appropriate icon
        color: iconColor,
        size: 15.0,
      ),
    ],
  );
}
