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
import '../services/login_service.dart';
import '../services/message_service.dart';
import 'package:tobehonest/controllers/memorybox_controller.dart';
import 'package:tobehonest/controllers/usedbox_controller.dart';

class ThanksMessage extends StatelessWidget {
  final WishItem wishItem; // WishItem 인스턴스를 필수 파라미터로 추가
  final ImagePicker _picker = ImagePicker();
  final controller = Get.put(ImagePickerController()); // 컨트롤러 인스턴스화
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final MemoryBoxController memoryBoxController = Get.put(MemoryBoxController());
  final ThankBoxController thankBoxController = Get.put(ThankBoxController());
  String _searchText = '';

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

  Future<void> sendPressed(ImagePickerController controller, String titleContent,
      String textFieldContent, WishItem wishItem) async {
    Message message;
    String? token;
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
    List<File> selectedFile = [];
    selectedFile.add(File(controller.selectedImage.value!.path));
    await sendThanksMessage(message, selectedFile, token!);
    await memoryBoxController.fetchUsedWishItems_Con(searchText: _searchText);
    await thankBoxController.fetchThnakWishItems_Con(searchText: _searchText);
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD3D3D3);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    '     고마운 사람들을 위해..',
                    style: TextStyle(
                      fontSize: 24, // 글씨 크기 조절
                    ),
                  ),
                ),
              ),

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
                margin: EdgeInsets.only(right: 24, left: 24, bottom: 16),
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
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: '내용을 적어주세요.',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: 200,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Obx(() => controller.selectedImage.value == null
                      ? Center(child: Text('사진을 추가해주세요.',style: TextStyle(fontSize: 18),))
                      : Image.file(File(controller
                      .selectedImage.value!.path))), // Obx를 사용하여 반응형으로 이미지 표시
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SendButton(
                  onPressed: () async {
                    if (controller.selectedImage.value != null) {
                      await sendPressed(controller,
                          titleController.text,
                          textEditingController.text,
                          wishItem);
                      Navigator.pop(context); // 현재 페이지 닫기
                      Navigator.pop(context); // 이전 페이지 닫기
                      Navigator.pop(context);
                    } else {
                      // 이미지가 선택되지 않았을 경우 처리
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('사진을 선택해주세요.')),
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: '사진 선택',
          child: Icon(Icons.add_a_photo),
          backgroundColor: AppColor.objectColor,
        ),
      ),
    );
  }
}
