// giftbox_controller.dart

import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/models/item.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import 'package:tobehonest/services/item_service.dart';
import '../services/login_service.dart';

class GiftBoxController extends GetxController {
  var wishItems = <WishItem>[].obs;
  var Items = <Item>[].obs;
  var isLoading = true.obs;

  Future<void> fetchCompleteWishItems_Con({String? searchText}) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

    await fetchCompletedWishItems(token);
    List<WishItem> CompletedWishItems = await getCompletedWishItems();

      // RxList의 assignAll 메서드로 데이터를 할당
      wishItems.assignAll(CompletedWishItems);

      // RxList의 refresh 메서드로 UI를 갱신
      wishItems.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }
}