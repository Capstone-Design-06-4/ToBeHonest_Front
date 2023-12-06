import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_contributed_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ItemDetailed extends StatelessWidget {
  final WishItem wishItem;

  ItemDetailed({required this.wishItem});

  @override
  Widget build(BuildContext context) {
    final double fundingProgress = wishItem.fundAmount / wishItem.itemPrice;

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      '   펀딩 중인 상품',
                      style: TextStyle(
                        fontSize: 28, // 글씨 크기 조절
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: 320,
                      height: 320,
                      margin: EdgeInsets.symmetric(vertical:10, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            wishItem.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 360,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  wishItem.itemBrand.length > 8
                                      ? '${wishItem.itemBrand.substring(0, 8)}...'
                                      : wishItem.itemBrand,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Spacer(), // 여기서 Spacer를 사용하여 공간을 꽉 채웁니다.
                                Text(
                                  '${formatNumber(wishItem.itemPrice)}',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.textColor),
                                ),
                                Text(
                                  ' 원',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              wishItem.itemName,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: FractionalOffset(fundingProgress >= 1 ? 1 : fundingProgress, 0.0),
                      child: FractionallySizedBox(
                        child: Icon(
                          Icons.arrow_drop_down, // 아이콘으로 대체
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                      child: LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        animation: true,
                        animationDuration: 1200,
                        lineHeight: 22.0,
                        percent: fundingProgress >= 1.0 ? 1.0 : fundingProgress,
                        barRadius: Radius.circular(16.0),
                        progressColor: Colors.green[400],
                        linearStrokeCap: LinearStrokeCap.roundAll,  // 이 속성을 추가하여 선의 끝 부분을 둥글게 만듭니다.
                        backgroundColor: Colors.grey[200],  // Container의 배경색과 동일한 효과를 위해 추가했습니다.
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '펀딩 진행중!',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '지금까지  ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '${(wishItem.fundAmount/wishItem.itemPrice*100).toStringAsFixed(2)}%',
                                  style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textColor),
                                ),
                                Text(
                                  '  모였어요.',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemContributed(wishItem: wishItem),
                        ),
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
                        '참여한 사람 보기',
                        style: TextStyle(fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
