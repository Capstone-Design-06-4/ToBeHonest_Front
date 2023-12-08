// friend_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobehonest/style.dart';
import 'package:get/get.dart';
import '../controllers/friend_search_controller.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';
import '../friend_function/friend_widgets/friend_list_widget.dart';
import '../friend_function/friend_widgets/friend_search_widget.dart';
import '../friend_function/friend_widgets/friend_add_click.dart';
import '../friend_function/friend_widgets/friend_categorized_widget.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:intl/intl.dart'; // DateFormat을 사용하기 위해 추가


class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  //final FriendController friendController = Get.find<FriendController>();
  final FriendController friendController = Get.put(FriendController());
  final AddController addController = Get.put(AddController());
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    setState(() {
      _scrollController.jumpTo(0);
    });
  }


  @override
  void initState() {
    super.initState();
    _update(); // initState에서 _update 호출하지 않음
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update(); // didChangeDependencies에서 _update 호출하여 데이터가 변경될 때마다 업데이트
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _update() async {
    try {
      await friendController.getFriendsList();
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    searchController.addListener(() async {
      String searchQuery = searchController.text;
      friendController.isAddingAllowed.value = searchQuery.isEmpty;
      if (searchQuery.isNotEmpty) {
        await friendController.searchFriends(searchQuery);
      } else {
        await friendController.getFriendsList();
      }
    });
    List<Friend> sortedFriendsList = sortFriendsByProximityToToday(friendController.friendsList);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 10,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            backgroundColor: AppColor.backgroundColor.withOpacity(0.8), // 완전 투명
            title: Text(' \n친구', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23, color: Colors.white)),
            actions: [
              Container(
                margin: EdgeInsets.only(top:25,right: 20), // 원하는 만큼의 마진을 설정
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowUp),
                  onPressed: () {
                    _scrollToTop();
                  },
                ),
              ),
            ],

          ),
        ),
        body: ListView(
          controller: _scrollController,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: AppColor.backgroundColor.withAlpha(200),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16,),
                child: Column(
                  children: [

                    SearchFriendWidget(controller: searchController),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            AddFriendTile(),
            Obx(() {
              if (friendController.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              }
              List<Friend> sortedFriendsList = sortFriendsByProximityToToday(friendController.friendsList);

              if(sortedFriendsList.length ==0) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.0),
                  child: Text('친구가 없어요.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sortedFriendsList.length,
                itemBuilder: (context, index) {
                  return buildFriendContainer(context, sortedFriendsList[index]);
                },
              );
            }),
          ],
        ),


      ),
    );
  }
}

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String strToday = formatter.format(now);
  return strToday;
}

// 추가: 날짜에 가까운 순으로 정렬하는 함수
List<Friend> sortFriendsByProximityToToday(List<Friend> friends) {
  String today = getToday();
  friends.sort((a, b) {
    // 각 친구의 생일에서 연도를 무시하고 월과 일만 가져오기
    DateTime aBirthday = DateTime.parse(a.birthDate);
    DateTime bBirthday = DateTime.parse(b.birthDate);

    DateTime aThisYearBirthday = DateTime(DateTime.now().year, aBirthday.month, aBirthday.day);
    DateTime bThisYearBirthday = DateTime(DateTime.now().year, bBirthday.month, bBirthday.day);

    // 생일과 오늘 날짜 간의 차이 계산
    Duration differenceA = aThisYearBirthday.difference(DateTime.parse(today));
    Duration differenceB = bThisYearBirthday.difference(DateTime.parse(today));

    // 과거 생일에 대한 처리: -365를 더한 후 절댓값 취하기
    if (differenceA.isNegative) {
      differenceA = Duration(days: 365) + differenceA;
    }
    if (differenceB.isNegative) {
      differenceB = Duration(days: 365) + differenceB;
    }

    // Debugging을 위해 print 문 추가
    print('Today: $today');
    print('Friend A: ${a.name}, Birthdate: ${aThisYearBirthday.toString()}, Difference: ${differenceA.inDays}');
    print('Friend B: ${b.name}, Birthdate: ${bThisYearBirthday.toString()}, Difference: ${differenceB.inDays}');

/*    // 월이 가까운 순으로 정렬
    int monthComparison = aThisYearBirthday.month.compareTo(bThisYearBirthday.month);
    if (monthComparison != 0) {
      return monthComparison;
    }*/

    // 같은 월인 경우 일이 가까운 순으로 정렬
    return differenceA.inDays.compareTo(differenceB.inDays);
  });

  return friends;
}


