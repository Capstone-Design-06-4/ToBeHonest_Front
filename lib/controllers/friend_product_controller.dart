import 'package:get/get.dart';
import 'package:tobehonest/models/wishItem.dart';
import 'package:tobehonest/services/wishlist_service.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:tobehonest/controllers/friend_wishlist_controller.dart';

class FriendProductController extends GetxController {
  var wishItem = WishItem(
      wishItemId: -1,
      itemBrand: '',
      itemName: '',
      image: '',
      itemPrice: 0,
      fundAmount: 0,
      itemId: -1).obs; // 관찰 가능한 WishItem 객체
  var friendID;
  final FriendWishListController wishListController = Get.put(
      FriendWishListController());

  FriendProductController(WishItem initialWishItem, int friendID) {
    wishItem.value = initialWishItem;
    this.friendID = friendID;
  }

  Future<void> updateWishItem() async {
    String? token = await getToken();
    if(token == null) throw Exception('로그인 다시하세요.');
    List<WishItem> list = await getFriendWishItemByWishItemID(friendID, wishItem.value.wishItemId, token);
    wishItem.value = list[0];
    await wishListController.fetchFriendWishItems_Con(friendID: friendID);
  }

// 필요한 경우 추가 메서드를 구현합니다.
}