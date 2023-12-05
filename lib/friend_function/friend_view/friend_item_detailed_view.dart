import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/services/contribute_service.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:intl/intl.dart';
import 'package:tobehonest/friend_function/friend_widgets/friend_product_widget.dart';
import 'package:tobehonest/friend_function/friend_widgets/friend_contribute_widget.dart';
import 'package:tobehonest/controllers/friend_product_controller.dart';

class FriendItemDetailed extends StatefulWidget {
  final WishItem wishItem;
  final int friendID;
  final String friendName;
  FriendItemDetailed({required this.friendName, required this.wishItem, required this.friendID});

  @override
  _ItemDetailedState createState() => _ItemDetailedState();
}

class _ItemDetailedState extends State<FriendItemDetailed> {
  late FriendProductController friendProductController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    friendProductController =
        Get.put(FriendProductController(widget.wishItem, widget.friendID));
  }

  Future<void> onContributeButtonPressed() async {
    final WishItem wishItem = widget.wishItem;

    int? fundAmount = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: 220, // 모달 높이 크기
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          leading: CircleAvatar(
                            backgroundColor: AppColor.swatchColor,
                            child: Icon(Icons.attach_money, color: Colors.white),
                          ),
                          title: Text(
                            '펀딩하실 금액을 적어주세요.',
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80.0,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: amountController,
                          decoration: InputDecoration(
                            labelText: "포인트 입력",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // 금액이 유효한지 확인합니다.
                            if (value == null || value.isEmpty) {
                              return '금액을 입력해주세요.';
                            }
                            int? amount = int.tryParse(value);
                            if (amount == null || amount <= 0) {
                              return '유효한 금액을 입력해주세요.';
                            }
                            return null; // 유효한 경우에는 null을 반환합니다.
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(7),
                          ],
                          style: TextStyle(fontSize: 20), // Set the font size
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            int? amount = int.tryParse(amountController.text);

                            // 다이얼로그를 띄워 사용자에게 한 번 더 확인
                            bool confirm = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("펀딩 확인"),
                                  content: Text("정말로 펀딩하시겠습니까?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // 취소
                                      },
                                      child: Text("취소"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true); // 확인
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm == true) {
                              // 확인을 선택한 경우에만 펀딩 진행
                              Get.snackbar("알림", "펀딩이 완료되었습니다.",
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(seconds: 2),);
                              Navigator.of(context).pop(amount);
                              // 나머지 펀딩 로직은 여기에 추가
                            }
                          }
                        },

                        child: FittedBox(
                          child: Text(
                            '펀딩하기',
                            style: TextStyle(fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );

    String? token = await getToken();
    if (token == null) throw Exception('다시 로그인하세요.');

    if (fundAmount != null && fundAmount > 0) {
      try {
        final response =
        await contributeToFriend(wishItem, fundAmount, widget.friendID, token);
        await friendProductController.updateWishItem();
        // 이후의 로직은 위와 동일
      } catch (e) {
        print('오류 발생: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final WishItem wishItem = widget.wishItem;
    final double fundingProgress = wishItem.fundAmount / wishItem.itemPrice;

    String formatNumber(int number) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
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
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Obx(() => FriendProductWidget(
                      friendID: widget.friendID,
                      wishItem: friendProductController.wishItem.value,
                      friendName: widget.friendName,
                    )),
                    FriendContributeWidget(onContribute: () async {
                      await onContributeButtonPressed();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
