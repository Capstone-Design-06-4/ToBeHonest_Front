import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  var selectedImage = Rxn<XFile>(); // 선택된 이미지를 관리하는 Rxn 변수

  void pickImage(XFile? image) {
    selectedImage.value = image;
  }
}
