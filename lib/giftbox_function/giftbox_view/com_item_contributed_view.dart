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
                    Navigator.pop(context); // 이전 경로로 돌아가기
                    Navigator.pop(context); // 이전 경로로 돌아가기
                    Navigator.pop(context); // 이전 경로로 돌아가기

                    // 여기에 다른 페이지로 이동하는 코드 추가
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
            Expanded(
              child: Obx(() {
                if (widget.contributorController.ContributorList.isEmpty || widget.wishItem.fundAmount == 0) {
                  // contributors 리스트가 비어있을 때
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Text('아직 펀딩 참여자가 없습니다 :(',style: TextStyle(fontSize: 18,)),
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
                          title: Text(contributor.friendName),
                          trailing: Text(formatNumber(contributor.contribution)),
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
                              _scaffoldKey.currentState!.showBottomSheet(
                                    (context) => buildBottomSheet(context),
                              );
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
