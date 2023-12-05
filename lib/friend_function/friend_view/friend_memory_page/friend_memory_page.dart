import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';
import 'package:tobehonest/controllers/messagebox_controller.dart';
import 'package:tobehonest/models/message.dart';

class FriendMemoryPage extends StatefulWidget {
  final int friendID;
  final String friendName;
  FriendMemoryPage({Key? key, required this.friendName, required this.friendID})
      : super(key: key);

  @override
  _FriendMemoryPageState createState() => _FriendMemoryPageState();
}

class _FriendMemoryPageState extends State<FriendMemoryPage> {

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.put(MessageController(widget.friendID));
    messages = messageController.messages;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor,
            title: Text('${widget.friendName} 님의 위시리스트', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: AppColor.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('${widget.friendName}님', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height:20),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Obx(
                      () {
                    return messageController.isLoading.isTrue
                        ? Center(child: CircularProgressIndicator())
                        : buildMessagesListView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessagesListView() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatMessageWidget(
          message: messages[index],
          friendName: widget.friendName,
          friendID: widget.friendID,
        );
      },
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  final String friendName;
  final int friendID;

  ChatMessageWidget(
      {required this.message,
      required this.friendName,
      required this.friendID});

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    bool isCelebrateMessage =
        message.messageType == MessageType.CELEBRATION_MSG;
    bool isSenttoYou = message.receiverId == friendID;

    return Align(
      alignment: isSenttoYou ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment:
              isSenttoYou ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  buildGreetingText(isSenttoYou, isCelebrateMessage),
                  SizedBox(height: 5),
                  buildMaterial(isSenttoYou, isCelebrateMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGreetingText(bool isSenttoYou, bool isCelebrateMessage) {
    String greetingText;

    if (isSenttoYou && isCelebrateMessage) {
      //내가 펀딩
      greetingText = '펀딩에 참여했어요';
    } else if (isSenttoYou && !isCelebrateMessage) {
      // 내가 감사인사 주기
      greetingText = '감사인사를 전했어요';
    } else if (!isSenttoYou && isCelebrateMessage) {
      // 너가 펀딩
      greetingText = '$friendName님이 펀딩에 참여했어요';
    } else {
      // 너가 감사인사 주기
      greetingText = '$friendName님이 감사인사를 보냈어요';
    }

    return Text(greetingText);
  }

  Widget buildMaterial(bool isSenttoYou, isCelebrateMessage) {
    return Material(
      borderRadius: isSenttoYou
          ? BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )
          : BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
      elevation: 15.0,
      color: isSenttoYou ? AppColor.backgroundColor.withOpacity(0.8) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.messageImgURLs != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://i.pravatar.cc/150?img=1',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(width: 20),
            !isCelebrateMessage
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:5),
                      Text(
                        message.title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: isSenttoYou ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Your button press logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isSenttoYou ? Colors.white : AppColor.subColor,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(0, 36),
                        ),
                        child: Text(
                          '상세내역 보기',
                          style: TextStyle(fontSize: 14, color: isSenttoYou ? Colors.black : Colors.white),
                        ),
                      )

                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:10),
                      Text(
                        message.title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: isSenttoYou ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            '펀딩 총액: ',
                            style: TextStyle(fontSize: 15, color: !isSenttoYou ? Colors.black : Colors.white),
                          ),
                          Text(
                            isSenttoYou ? 'heeo' : '${formatNumber(message.fundMoney)}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: !isSenttoYou ? AppColor.textColor : Colors.white),
                          ),
                          Text(
                            ' 원',
                            style: TextStyle(fontSize: 15, color: !isSenttoYou ? Colors.black : Colors.white),
                          ),
                        ],
                      )

                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
