import 'package:flutter/material.dart';
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

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'ko_KR');
    String formattedAmount = formatter.format(amount);
    return '$formattedAmount 원';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                //controller 호출 자리
                return ListView.builder(
                  itemCount: widget.contributorController.ContributorList.length,
                  itemBuilder: (context, index) {
                    final contributor = widget.contributorController.ContributorList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(contributor.ProfileURL),
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
                              // 공유하기 기능 구현
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
                                '금액 채우기',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
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
                                          // 확인 버튼을 눌렀을 때의 동작
                                          Navigator.of(context).pop();  // 다이얼로그를 닫음
                                          await widget.wishListController.deleteFromWishlist_Con(widget.wishItem.wishItemId);
                                          print("Before popping twice");
                                          Navigator.popUntil(context, (route) => route.isFirst);  // 현재 페이지를 닫고 두 번 뒤로 이동
                                          print("After popping twice");
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
                              primary: Colors.orange.shade400,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                '위시리스트에서 삭제하기',
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
