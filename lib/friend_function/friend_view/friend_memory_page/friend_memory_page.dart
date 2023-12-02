import 'package:flutter/material.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';
import 'package:tobehonest/controllers/messagebox_controller.dart';
import 'package:tobehonest/models/message.dart';

class FriendMemoryPage extends StatefulWidget {
  final int friendID;
  final String friendName;

  FriendMemoryPage({Key? key, required this.friendName, required this.friendID}) : super(key: key);

  @override
  _FriendMemoryPageState createState() => _FriendMemoryPageState();
}

class _FriendMemoryPageState extends State<FriendMemoryPage> {
  List<Message> messages = [
    Message(
      wishItemId: 1,
      senderId: 1,
      receiverId: 2,
      title: '안녕하세요!',
      contents: '친구와의 소중한 추억을 공유해보아요.',
      messageType: MessageType.THANKS_MSG,
      fundMoney: 100,
      messageImgURLs: ['https://example.com/image1.jpg'],
    ),
    Message(
      wishItemId: 2,
      senderId: 1,
      receiverId: 2,
      title: '오늘의 이야기',
      contents: '함께한 순간들이 참 좋아서 기억 속에 간직하고 있어요.',
      messageType: MessageType.CELEBRATION_MSG,
      fundMoney: 150,
      messageImgURLs: ['https://example.com/image2.jpg'],
    ),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('${widget.friendName} 님과의 추억', style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessageWidget(message: messages[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  ChatMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: message.messageType == MessageType.THANKS_MSG
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  message.contents,
                  style: TextStyle(color: Colors.white),
                ),
                // Add more widgets to display other message properties if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
