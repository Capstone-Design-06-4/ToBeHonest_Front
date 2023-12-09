import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/models/message.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/controllers/contributor_controller.dart';
import 'package:tobehonest/navigation bar/wishlist_page.dart';
import 'package:get/get.dart';
import 'package:tobehonest/thanks_message/thanks_message_view.dart';
import 'package:tobehonest/memorybox_function/memorybox_view/messaged_show_view.dart';

class MessagedShowPage extends StatefulWidget {
  final WishItem wishItem;
  final Message message;

  MessagedShowPage({required this.wishItem, required this.message});

  @override
  _MessagedShowPageState createState() => _MessagedShowPageState();
}

class _MessagedShowPageState extends State<MessagedShowPage> {
  @override
  void initState() {
    super.initState();
  }

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
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
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 30),
                FaIcon(FontAwesomeIcons.heart, color: Colors.red, size: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      '  추억이 담긴 메시지',
                      style: TextStyle(
                        fontSize: 24, // 글씨 크기 조절
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.wishItem.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                widget.wishItem.itemBrand.length > 8
                                    ? '${widget.wishItem.itemBrand.substring(0, 8)}...'
                                    : widget.wishItem.itemBrand,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.wishItem.itemName,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '펀딩 총액: ',
                                style: TextStyle(fontSize: 18,),
                              ),
                              Text(
                                '${formatNumber(widget.wishItem.fundAmount)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textColor),
                              ),
                              Text(
                                ' 원',
                                style: TextStyle(fontSize: 18,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(right: 24, left: 24, bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,  // 원하는 테두리 색상 설정
                  width: 1.0,  // 원하는 테두리 두께 설정
                ),
                borderRadius: BorderRadius.circular(0.0),  // 원하는 테두리의 둥근 정도 설정
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,  // 수정된 부분
                  children: [
                    Icon(
                      Icons.title,
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.message.title,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.right,  // 텍스트를 우측 정렬로 설정
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 24, left: 24, bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,  // Column의 크기를 최소로 유지
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 125,
                              height: 125,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.message.messageImgURLs.isEmpty
                                        ? "https://via.placeholder.com/200"
                                        : widget.message.messageImgURLs[0],
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _showImageFullScreen(context, widget.message.messageImgURLs);
                                },
                                child: Hero(
                                  tag: 'enlargedImg', // Provide a unique tag for the Hero widget
                                  child: Image.network(
                                    widget.message.messageImgURLs.isEmpty
                                        ? "https://via.placeholder.com/200"
                                        : widget.message.messageImgURLs[0],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.message.contents,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            // 추가적인 위젯을 여기에 추가할 수 있습니다.
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.backgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(0, 36),
                            ),
                            child: FittedBox(
                              child: Text(
                                '홈으로 이동하기',
                                style: TextStyle(fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

void _showImageFullScreen(BuildContext context, List<String> messageImgURLs) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
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
        body: Center(
          child: Hero(
            tag: 'enlargedImg', // Same tag as in the original page
            child: Image.network(
              messageImgURLs.isEmpty
                  ? "https://via.placeholder.com/200"
                  : messageImgURLs[0],
            ),
          ),
        ),
      ),
    ),
  );
}



