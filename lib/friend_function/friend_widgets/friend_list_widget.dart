import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:tobehonest/friend_function/friend_view/friend_detailed_view.dart';
import 'package:tobehonest/friend_function/friend_view/friend_wishlist_view.dart'; // Import the necessary file

Widget buildFriendContainer(BuildContext context, Friend friend) {
  return GestureDetector(
    onTap: () {
      ModalUtils.showFriendModal(context, friend);
    },
    child: Container(
      height: 60.0,
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
                backgroundImage: NetworkImage(friend.profileURL), // Provide the friend's profile image URL
                radius: 30.0,
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(friend.birthDate, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
                  Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                friend.myGive ? FontAwesomeIcons.gift : FontAwesomeIcons.gifts,
                color: friend.myGive ? Colors.red : Colors.grey,
              ),
              const SizedBox(width: 30.0),
              Icon(
                friend.myTake ? FontAwesomeIcons.gift : FontAwesomeIcons.gifts,
                color: friend.myTake ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 35.0),
              const Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.grey),
              const SizedBox(width: 5.0),
            ],
          ),
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
          height: 250, // 모달 높이 크기
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 40,
          ), // 모달 좌우하단 여백 크기
          decoration: const BoxDecoration(
            color: Colors.white, // 모달 배경색
            borderRadius: BorderRadius.all(
              Radius.circular(20), // 모달 전체 라운딩 처리
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 70.0,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundColor: AppColor.swatchColor,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(friend.profileURL), // Provide the friend's profile image URL
                        radius: 60.0,
                      ),
                    ),
                    title: Text(
                      friend.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    subtitle: Text(friend.birthDate),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear, // You can change this to any other icon
                        color: Colors.black,
                      ),
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
