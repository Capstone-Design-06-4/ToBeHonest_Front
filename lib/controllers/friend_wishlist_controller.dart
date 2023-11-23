// wishlist_controller.dart

import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/models/item.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import 'package:tobehonest/services/item_service.dart';
import '../services/login_service.dart';

class FriendWishListController extends GetxController {
  var wishItems = <WishItem>[].obs;
  var Items = <Item>[].obs;
  var isLoading = false.obs;

  Future<void> fetchFriendWishItems_Con({int? friendID, String? searchText}) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");
      if(friendID == null) throw Exception("friendID가 없습니다.");
      await fetchFriendWishItems(friendID, token);

      List<WishItem> allWishItems = [];
      allWishItems.addAll(await getFriendWishItems());

      // RxList의 assignAll 메서드로 데이터를 할당
      wishItems.assignAll(allWishItems);

      // RxList의 refresh 메서드로 UI를 갱신
      wishItems.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }
}