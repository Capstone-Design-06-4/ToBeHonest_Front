// wishlist_controller.dart

import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import '../services/login_service.dart';

class WishListController extends GetxController {
  var wishItems = <WishItem>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishItems_Progress();
  }

  Future<void> fetchWishItems_Progress({String? searchText}) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      await fetchProgressWishItems(token, searchText: searchText);

      List<WishItem> allWishItems = [];
      allWishItems.addAll(await getProgressWishItems());

      wishItems.assignAll(allWishItems);
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addToWishlist(String itemID) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      await fetchWishItems_Progress();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }
}
