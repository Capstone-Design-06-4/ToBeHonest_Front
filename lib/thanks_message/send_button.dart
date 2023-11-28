import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';

class SendButton extends StatelessWidget {
  final VoidCallback? onPressed; // 콜백 함수를 위한 매개변수

  SendButton({Key? key, this.onPressed}) : super(key: key); // 생성자
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: AppColor.backgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(0, 36),
              ),
              child: Text(
                '감사 메시지 보내기',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
