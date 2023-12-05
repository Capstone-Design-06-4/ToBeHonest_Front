import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: Text('작성한 메세지'),
          centerTitle: true,
          backgroundColor: AppColor.backgroundColor,
        ),
        body: Column(
          children: [
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
            Container(
              margin: EdgeInsets.only(right: 24, left: 24, bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,  // 원하는 테두리 색상 설정
                  width: 1.0,  // 원하는 테두리 두께 설정
                ),
                borderRadius: BorderRadius.circular(8.0),  // 원하는 테두리의 둥근 정도 설정
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
              width: double.infinity,  // 원하는 가로 크기 설정
              height: 230,  // 원하는 세로 크기 설정
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,  // 원하는 테두리 색상 설정
                  width: 1.0,  // 원하는 테두리 두께 설정
                ),
                borderRadius: BorderRadius.circular(8.0),  // 원하는 테두리의 둥근 정도 설정
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          widget.message.contents,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 130,  // 그리드뷰의 높이 설정
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1, // 우리는 아직 이미지 하나만 주고 받아서
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemBuilder: (context, index) {
                  String imgUrl = widget.message.messageImgURLs.isEmpty ?
                  "https://via.placeholder.com/200" : widget.message.messageImgURLs[0];
                  return Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15,),
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
                  SizedBox(height: 15,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}