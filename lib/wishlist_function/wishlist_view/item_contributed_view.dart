import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/controllers/wishlist_controlller.dart';
import 'package:tobehonest/controllers/contributor_controller.dart';
import 'package:tobehonest/navigation bar/wishlist_page.dart';
import 'package:get/get.dart';

class ItemContributed extends StatefulWidget {
  final WishItem wishItem;
  final ContributorController contributorController = Get.put(ContributorController());
  final WishListController wishListController = Get.put(WishListController());

  ItemContributed({required this.wishItem});

  @override
  _ItemContributedState createState() => _ItemContributedState();
}

class _ItemContributedState extends State<ItemContributed> {
  @override
  void initState() {
    super.initState();
    widget.contributorController.setWishItemIDAndFetchContributors(widget.wishItem.wishItemId);
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('진짜 삭제할거?'),
                                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await widget.wishListController.deleteFromWishlist_Con(widget.wishItem.wishItemId);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text('확인'),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          // 아니오 버튼을 눌렀을 때의 동작
                                          Navigator.of(context).pop();  // 다이얼로그를 닫음
                                        },
                                        child: Text('아니오'),
                                      ),
                                    ],
                                  );
                                },
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
                                '위시리스트에서 삭제하기',
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
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
