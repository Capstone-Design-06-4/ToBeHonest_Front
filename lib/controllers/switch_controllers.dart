import 'package:get/get.dart';

class switchController   extends GetxController {
  RxBool isLiked = false.obs;

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }
}
