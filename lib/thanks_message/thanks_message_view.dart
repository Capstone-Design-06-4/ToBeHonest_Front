import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
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

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

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
          title: Text('메시지 보내기'),
          centerTitle: true,
          backgroundColor: AppColor.backgroundColor,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            wishItem.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                wishItem.itemBrand.length > 8
                                    ? '${wishItem.itemBrand.substring(0, 8)}...'
                                    : wishItem.itemBrand,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            wishItem.itemName,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '펀딩 총액: ',
                                style: TextStyle(fontSize: 18,),
                              ),
                              Text(
                                '${formatNumber(wishItem.fundAmount)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textColor),
                              ),
                              Text(
                                ' 원',
                                style: TextStyle(fontSize: 18,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
