import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import './ProductDetailsWidget.dart';
import '../controllers/image_picker_controller.dart';
import '../models/wishItem.dart';
import '../models/message.dart';

class ThanksMessage extends StatelessWidget {
  final WishItem wishItem; // WishItem 인스턴스를 필수 파라미터로 추가
  final ImagePicker _picker = ImagePicker();
  final controller = Get.put(ImagePickerController()); // 컨트롤러 인스턴스화

  ThanksMessage({Key? key, required this.wishItem})
      : super(key: key); // 생성자에 required 파라미터 추가

  Future<void> _pickImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    controller.pickImage(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('감사 메시지 보내기'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: ProductDetailsWidget(
              wishItem: wishItem, // ProductDetailsWidget에 wishItem 전달
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '제목',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Obx(() => controller.selectedImage.value == null
                  ? Text('사진을 선택해주세요.')
                  : Image.file(File(controller
                      .selectedImage.value!.path))), // Obx를 사용하여 반응형으로 이미지 표시
            ),
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // 전송 로직 구현
                  if (controller.selectedImage.value != null) {
                    // 이미지 파일 객체 생성
                    File selectedFile = File(controller.selectedImage.value!.path);

                    // 이미지 처리 함수 호출
                    //await sendMessage(selectedFile);
                  } else {
                    // 이미지가 선택되지 않았을 경우의 처리
                    // 예: 사용자에게 알림 표시
                  }
                },
                child: Text('전송하기'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: '사진 선택',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
