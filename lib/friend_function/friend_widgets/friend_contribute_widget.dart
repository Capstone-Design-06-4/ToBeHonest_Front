// friend_contribute_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tobehonest/style.dart';

class FriendContributeWidget extends StatelessWidget {
  final Future<void> Function() onContribute;
  FriendContributeWidget({Key? key, required this.onContribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: () async {
            await onContribute();
            print('펀딩하기 눌렸음');
            Get.snackbar(
              "알림",
              "펀딩이 완료되었습니다.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.transparent,
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
              '펀딩하기',
              style: TextStyle(fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
