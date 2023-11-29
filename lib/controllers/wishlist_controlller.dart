// wishlist_controller.dart

import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/models/item.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import 'package:tobehonest/services/item_service.dart';
import '../services/login_service.dart';

class WishListController extends GetxController {
  var wishItems = <WishItem>[].obs;
  var Items = <Item>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchProgressWishItems_Con(); // refresh 함수를 비동기 방식으로 호출
  }

  Future<bool> isItemAlreadyAdded(int itemId) async {
    // 이미 추가된 상품인지 여부를 확인하는 로직
    String? token = await getToken() ?? "";
    await fetchProgressWishItems(token);
    List<WishItem> progressWishItems = await getProgressWishItems();
    return progressWishItems.any((item) =>
    item.itemId == itemId); //itemId로 바꿔야함
  }

  Future<void> addToWishlistWithSnackbar(Item selectedItem) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      // 이미 추가된 상품인지 확인
      if (await isItemAlreadyAdded(selectedItem.id)) {
        // 이미 추가된 상품이면 Snackbar를 표시하고 함수 종료
        Get.snackbar("알림", "이미 추가된 상품입니다.", snackPosition: SnackPosition.TOP);
        return;
      }

      // 추가되지 않은 상품이면 Wishlist에 추가
      await addWishlist(selectedItem.id, token);

      // 데이터 갱신 및 UI 갱신
      await fetchProgressWishItems_Con();

      // 추가 성공 시 Snackbar 표시
      Get.snackbar(
          "알림", "상품이 위시리스트에 추가되었습니다.", snackPosition: SnackPosition.TOP);
    } catch (e) {
      print('오류 발생: $e');

      // 실패 시 Snackbar 표시
      Get.snackbar("알림", "상품 추가에 실패했습니다.", snackPosition: SnackPosition.TOP);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProgressWishItems_Con({String? searchText}) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      await fetchProgressWishItems(token);

      List<WishItem> allWishItems = [];
      allWishItems.addAll(await getProgressWishItems());

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

// 위시리스트에 상품을 추가하는 메서드
  Future<void> addToWishlist_Con(int itemID) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      // 위시리스트에 상품 추가
      await addWishlist(itemID, token);

      // 데이터 갱신 및 UI 갱신
      await fetchProgressWishItems_Con();
      // No need to assign an empty list here
      update();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

// 검색어를 사용하여 상품을 추가하고 UI 갱신하는 메서드
  Future<void> ItemAddSearch(String searchText) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      print('검색어로 상품을 찾는 중...');

      // 검색어를 사용하여 상품을 찾음
      List<Item> searchedItems = await findItemByKeyword(searchText, token);

      // RxList의 assignAll 메서드로 데이터를 할당
      Items.assignAll(searchedItems);

      // RxList의 refresh 메서드로 UI를 갱신
      Items.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> ItemAddSearchbyCategory(String searchText) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      print('검색어로 상품을 찾는 중...');

      // 검색어를 사용하여 상품을 찾음
      List<Item> searchedItems = await findItemByCategory(searchText, token);

      // RxList의 assignAll 메서드로 데이터를 할당
      Items.assignAll(searchedItems);

      // RxList의 refresh 메서드로 UI를 갱신
      Items.refresh();
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteFromWishlist_Con(int wishItemID) async {
    try {
      isLoading(true);

      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      await deleteWishlist(wishItemID, token);

      // 삭제 후에 fetchProgressWishItems_Con 메서드로 데이터를 다시 가져옴
      await fetchProgressWishItems_Con();

      // RxList의 assignAll 메서드로 데이터를 할당
      wishItems.assignAll(await getProgressWishItems());

      // RxList의 refresh 메서드로 UI를 갱신
      wishItems.refresh();
      update();
      Get.snackbar(
          "알림", "상품이 위시리스트에서 삭제되었습니다.", snackPosition: SnackPosition.TOP);
    } catch (e) {
      print('오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

}