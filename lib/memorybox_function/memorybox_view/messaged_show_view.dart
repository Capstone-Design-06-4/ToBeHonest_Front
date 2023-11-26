import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';

class MessagedShowPage extends StatelessWidget {
  const MessagedShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaged Show Page'),
        backgroundColor: Colors.orange[200],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('TO BE CONTINUED...'),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // 현재 페이지 닫기
                        Navigator.pop(context); // 이전 페이지 닫기
                        Navigator.pop(context); // 그 이전 페이지 닫기
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
                          '홈화면으로 이동하기',
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
    );
  }
}
