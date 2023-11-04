import 'package:flutter/material.dart';

class AddFriendTile extends StatelessWidget {
  const AddFriendTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
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
    );
  }
}
