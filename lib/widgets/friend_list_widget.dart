import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/friend.dart';
import '../friend_view/friend_detailed_view.dart';

Widget buildFriendContainer(BuildContext context, Friend friend) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FriendDetailPage(friend: friend),
        ),
      );
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
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
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
              const SizedBox(width: 30.0),
              const Icon(Icons.arrow_forward_ios, size: 25.0, color: Colors.grey),
            ],
          ),
        ],
      ),
    ),
  );
}
