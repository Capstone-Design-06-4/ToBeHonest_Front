import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import './ProductDetailsWidget.dart';
import '../controllers/image_picker_controller.dart';
import '../models/wishItem.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import '../services/login_service.dart';

class SendButton extends StatelessWidget {
  final ImagePickerController controller;
  final String titleContent; // TextFormField의 내용
  final String textFieldContent; // TextFormField의 내용
  final WishItem wishItem; // WishItem 인스턴스
  late Message message;
  late String? token;
  SendButton({
    Key? key,
    required this.controller,
    required this.titleContent, // 생성자에 추가
    required this.textFieldContent, // 생성자에 추가
    required this.wishItem, // 생성자에 추가
  }) : super(key: key);

  Future<void> createMessage() async {
    token = await getToken();
    String? myID = await getID();
    if(token == null || myID == null) throw Exception('로그인 다시하세요.');
    message = Message(wishItemId: wishItem.wishItemId,
        senderId: int.parse(myID),
        receiverId: 0,
        title: titleContent,
        contents: textFieldContent,
        messageType: MessageType.THANKS_MSG,
        fundMoney: wishItem.fundAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (controller.selectedImage.value != null) {
                  File selectedFile = File(controller.selectedImage.value!.path);
                  await createMessage();
                  await sendThanksMessage(message, selectedFile, token!);
                } else {
                  // 이미지가 선택되지 않았을 경우 처리
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('사진을 선택해주세요.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange.shade400,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(0, 36),
              ),
              child: Text(
                '감사 메시지 보내기',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
