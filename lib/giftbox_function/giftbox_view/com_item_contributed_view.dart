import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/controllers/contributor_controller.dart';
import 'package:tobehonest/controllers/giftbox_controller.dart';
import 'package:tobehonest/navigation bar/wishlist_page.dart';
import 'package:get/get.dart';
import 'package:tobehonest/navigation bar/memorybox_page.dart';
import 'package:tobehonest/thanks_message/thanks_message_view.dart';

class ComItemContributed extends StatefulWidget {
  final WishItem wishItem;
  final ContributorController contributorController = Get.put(ContributorController());
  final WishListController wishListController = Get.put(WishListController());
  final GiftBoxController giftBoxController = Get.put(GiftBoxController()); // 추가된 부분

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

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'ko_KR');
    String formattedAmount = formatter.format(amount);
    return '$formattedAmount 원';
  }

  Widget buildBottomSheet() {
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
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              widget.wishItem.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              widget.wishItem.itemBrand,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.wishItem.itemName,
                              style: TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '펀딩 모금액',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  formatCurrency(widget.wishItem.fundAmount),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: widget.contributorController.ContributorList.length,
                  itemBuilder: (context, index) {
                    final contributor = widget.contributorController.ContributorList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(contributor.ProfileURL),
                        ),
                        title: Text(contributor.friendName),
                        trailing: Text(formatCurrency(contributor.contribution)),
                      ),
                    );
                  },
                );
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
                                    (context) => buildBottomSheet(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade300,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                '내 계좌로 송금하기',
                                style: TextStyle(fontSize: 16),
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
