import 'package:get/get.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';
import '../services/login_service.dart'; // 로그인 서비스를 추가합니다.
import '../services/message_service.dart';

class MessageController extends GetxController {
  var friendID; // 친구 목록을 저장하는 RxList
  var isLoading = false.obs; // 로딩 상태를 나타내는 RxBool

  Future<void> getMessageList(friendID) async {
    isLoading(true); // 로딩 상태를 true로 설정
    try {
      String? token = await getToken();
      print('토큰: $token'); // 로그인 서비스에서 토큰을 가져옵니다.
      if (token != null) {
        await getMessageWithFriend(friendID, token);
      } else {
        print('토큰이 없습니다.');
      }
      friendID.refresh();
    } catch (e) {
      print('친구 목록을 가져오는 데 실패했습니다: $e');
    } finally {
      isLoading(false); // 로딩 상태를 false로 설정
    }
  }
}