import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';
import '../services/login_service.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import 'package:tobehonest/services/item_service.dart';
import '../services/login_service.dart';

class MyInfoController extends GetxController {
  var percentage;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getPercentage();
  }

  Future<void> getPercentage() async {
    String? token = await getToken();
    if(token == null) throw Exception('로그인 다시하세요.');
    percentage = await getMyExpected(token);
    return percentage;
  }
// 필요한 경우 여기에 기타 로직 추가
}
