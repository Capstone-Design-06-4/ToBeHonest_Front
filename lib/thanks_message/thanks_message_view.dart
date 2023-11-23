import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import './ProductDetailsWidget.dart';
import './send_button.dart';
import '../controllers/image_picker_controller.dart';
import '../models/wishItem.dart';
import '../models/message.dart';

class ThanksMessage extends StatelessWidget {
  final WishItem wishItem; // WishItem 인스턴스를 필수 파라미터로 추가
  final ImagePicker _picker = ImagePicker();
  final controller = Get.put(ImagePickerController()); // 컨트롤러 인스턴스화
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

  ThanksMessage({Key? key, required this.wishItem})
      : super(key: key); // 생성자에 required 파라미터 추가

  Future<void> _pickImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    controller.pickImage(selected);
  }
  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'ko_KR');
    String formattedAmount = formatter.format(amount);
    return '$formattedAmount 원';
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD3D3D3);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('감사 메시지 보내기'),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
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
                              wishItem.image,
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
                              wishItem.itemBrand,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              wishItem.itemName,
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
                                  formatCurrency(wishItem.fundAmount),
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
            Container(
              margin: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: const Icon(Icons.title, size: 30),
                      hintText: '제목을 적어주세요!',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1.0), // 연한 회색 테두리 적용
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1.0), // 연한 회색 테두리 적용
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: '내용을 적어주세요.',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Obx(() => controller.selectedImage.value == null
                    ? Text('사진을 추가해주세요.')
                    : Image.file(File(controller
                    .selectedImage.value!.path))), // Obx를 사용하여 반응형으로 이미지 표시
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SendButton(
                  controller: controller,
                  titleContent: titleController.text,
                  textFieldContent: textEditingController.text,
                  wishItem: this.wishItem,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: '사진 선택',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Colors.orange[300],
        ),
      ),
    );
  }
}
