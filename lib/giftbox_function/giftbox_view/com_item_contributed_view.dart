import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/controllers/contributor_controller.dart';
import 'package:tobehonest/controllers/giftbox_controller.dart';
import 'package:get/get.dart';
import 'package:tobehonest/navigation bar/wishlist_page.dart';
import 'package:tobehonest/navigation bar/memorybox_page.dart';
import 'package:tobehonest/thanks_message/thanks_message_view.dart';

class ComItemContributed extends StatefulWidget {
  final WishItem wishItem;
  final ContributorController contributorController = Get.put(ContributorController());
  final WishListController wishListController = Get.put(WishListController());
  final GiftBoxController giftBoxController = Get.put(GiftBoxController());

  ComItemContributed({required this.wishItem});

  @override
  _ComItemContributedState createState() => _ComItemContributedState();
}

class _ComItemContributedState extends State<ComItemContributed> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    widget.contributorController.setWishItemIDAndFetchContributors(widget.wishItem.wishItemId);
  }

  // 페이지 초기화 함수
  void _resetPage() {
    // 현재 페이지를 팝하고 다시 푸시하여 페이지를 초기화하고 다시 그림
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ComItemContributed(wishItem: widget.wishItem)),
    );
  }

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '송금 확인',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('계좌로 송금하시겠습니까?'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await widget.giftBoxController.SendtoMyAccount(wishItemID: widget.wishItem.wishItemId);
                    _resetPage();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('참여한 사람들'),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '펀딩 참여자 수: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${widget.contributorController.ContributorList.length}',
                    style: TextStyle(fontSize: 18, color: AppColor.textColor),
                  ),
                  Text(
                    ' 명',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (widget.contributorController.ContributorList.isEmpty || widget.wishItem.fundAmount == 0) {
                  // contributors 리스트가 비어있을 때
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Text('',style: TextStyle(fontSize: 18,)),
                  );
                } else {
                  // contributors 리스트가 비어있지 않을 때
                  return ListView.builder(
                    itemCount: widget.contributorController.ContributorList.length,
                    itemBuilder: (context, index) {
                      final contributor = widget.contributorController.ContributorList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(contributor.ProfileURL),
                          ),
                          title: Text(contributor.friendName + ' 님'),
                          trailing: Text(formatNumber(contributor.contribution)+' 원'),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
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
                              ModalUtils.showFriendModal(context, widget.wishItem.wishItemId);
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
                                '송금하기',
                                style: TextStyle(fontSize: 18),
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
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

class ModalUtils {
  static void showFriendModal(BuildContext context, int wishItemId,) {
    final WishListController wishListController = Get.put(WishListController());
    final GiftBoxController giftBoxController = Get.put(GiftBoxController());
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150, // 모달 높이 크기
            decoration: BoxDecoration(
              color: Colors.white, // 모달 배경색
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
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
                Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundColor: AppColor.swatchColor,
                        child: Icon(Icons.question_mark, color: Colors.white),
                      ),
                      title: Text('계좌로 송금하시겠어요?',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context); // 예시: 현재 페이지를 닫음
                        },
                      ),
                    ),
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () async {
                      await giftBoxController.SendtoMyAccount(wishItemID: wishItemId);
                      await giftBoxController.refresh();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },

                    child: FittedBox(
                      child: Text(
                        '송금하기',
                        style: TextStyle(fontSize: 18,
                        ),
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