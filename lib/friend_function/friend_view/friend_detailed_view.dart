import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/friend_function/friend_view/friend_wishlist_view.dart';

class ModalUtils {
  static void showFriendModal(BuildContext context, String name, int id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Modal content
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendWishlistPage(friendName: name, friendID: id),
                    ),
                  );
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 60.0,
                        ),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      subtitle: Text(''), // Add the appropriate subtitle
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendWishlistPage(friendName: name, friendID: id),
                    ),
                  );
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(''), // Use the appropriate URL or placeholder
                          radius: 60.0,
                        ),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      subtitle: Text(''), // Add the appropriate subtitle
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
                        builder: (context) => FriendWishlistPage(friendName: name, friendID: id),
                      ));
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendWishlistPage(friendName: name, friendID: id),
                      ));
                },
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
              // Add other GestureDetector widgets as needed
            ],
          ),
        );
      },
    );
  }
}
