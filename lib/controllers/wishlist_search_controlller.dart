import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';

import 'package:tobehonest/services/wishlist_service.dart';
import '../services/login_service.dart'; // 로그인 관련 서비스 import

class WishListController extends GetxController {
  var wishItems = <WishItem>[].obs; // Obx로 상태를 감시하는 RxList

  @override
  void onInit() {
    super.onInit();
    // 컨트롤러가 초기화될 때 호출되는 부분
    fetchWishItems(); // 초기 위시 아이템 가져오기
  }

  Future<void> fetchWishItems() async {
    try {
      String? token = await getToken(); // 사용자 토큰을 얻음
      print('토큰: $token'); // 토큰 로그 출력
      if (token == null) throw Exception("토큰이 없습니다."); // 토큰이 없으면 예외 발생

      await fetchProgressWishItems(token); // 진행 중인 위시 아이템 가져오기

      // 모든 위시 아이템을 wishItems 리스트에 추가
      List<WishItem> allWishItems = [];
      allWishItems.addAll(await getProgressWishItems());

      // Obx 변수에 저장
      wishItems.assignAll(allWishItems);
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  Future<void> addToWishlist(String itemID) async {
    try {
      String? token = await getToken(); // 사용자 토큰을 얻음
      print('토큰: $token'); // 토큰 로그 출력
      if (token == null) throw Exception("토큰이 없습니다."); // 토큰이 없으면 예외 발생

      await fetchWishItems(); // 업데이트된 위시 아이템 가져오기
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}
