import 'package:flutter/material.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';
import 'package:tobehonest/controllers/messagebox_controller.dart';
import 'package:tobehonest/models/message.dart';
import '../friend_memory_page/friend_memory_detailed_page.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';

class FriendMemoryPage extends StatefulWidget {
  final int friendID;
  final String friendName;

  final WishListController wishListController = Get.put(WishListController());

  FriendMemoryPage({Key? key, required this.friendName, required this.friendID})
      : super(key: key);

  @override
  _FriendMemoryPageState createState() => _FriendMemoryPageState();
}

class _FriendMemoryPageState extends State<FriendMemoryPage> {
  final MessageController messageController = Get.find<MessageController>();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //messages = messageController.messages;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 20), // Adjust the top and left margins as needed
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: AppColor.backgroundColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Color(0xFFfbfbf2),
            elevation: 0,
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
                            child: Text('${widget.friendName}님과의 추억', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                      () {
                      if(messageController.messages.length ==0) {
                      return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0),
                      child: Text('${widget.friendName}님과의 추억을 쌓아봐요!',
                      style: TextStyle(
                      fontSize: 18,
                      )),
                      );
                      }
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
      itemCount: messageController.messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: ChatMessageWidget(
            message: messageController.messages[index],
            friendName: widget.friendName,
            friendID: widget.friendID,
          ),
        );
      },
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  final String friendName;
  final int friendID;
  late final WishItem wishItem;

  final WishListController wishListController = Get.put(WishListController());

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
      color: isSenttoYou ? Color(0xFFFFEAAE) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(message.itemImage != null && message.messageImgURLs != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  (message.messageImgURLs.isNotEmpty
                      ? message.messageImgURLs[0]
                      : message.itemImage) ?? '기본 이미지 URL',
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
                  message.title.length > 10
                      ? '${message.title.substring(0, 10)}...'
                      : message.title ?? "빈 제목",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: isSenttoYou ? Colors.black : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // 텍스트를 한 줄로 제한
                ),
                Text(
                  message.contents.length > 10
                      ? '${message.contents.substring(0, 10)}...'
                      : message.contents ?? "빈 제목",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: isSenttoYou ? Colors.black : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // 텍스트를 한 줄로 제한
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    print("버튼이 눌렸어요!");
                    print(message.wishItemId);
                    WishItem? wishItem = await wishListController.getWishItem(message.wishItemId);
                    print(message.wishItemId);
                    print('와사보1');
                    if (wishItem != null) {
                      print(message.wishItemId);
                      print('와사보2');
                      this.wishItem = wishItem;
                      Get.to(MessagedShowPage(wishItem: this.wishItem!, message: message));
                      print('와사보3');
                    }
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
                  message.title.length > 10
                      ? '${message.title.substring(0, 10)}...'
                      : message.title ?? "빈 제목",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: isSenttoYou ? Colors.black : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // 텍스트를 한 줄로 제한
                ),
                Text(
                  message.contents.length > 10
                      ? '${message.contents.substring(0, 10)}...'
                      : message.contents ?? "빈 제목",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: isSenttoYou ? Colors.black : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // 텍스트를 한 줄로 제한
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      '펀딩 금액: ',
                      style: TextStyle(fontSize: 15, color: !isSenttoYou ? Colors.black : Colors.black),
                    ),
                    Text(
                      '${formatNumber(message.fundMoney)}' ?? '0',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: !isSenttoYou ? AppColor.textColor : AppColor.textColor),
                    ),
                    Text(
                      ' 원',
                      style: TextStyle(fontSize: 15, color: !isSenttoYou ? Colors.black : Colors.black),
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
