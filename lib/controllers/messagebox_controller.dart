import 'package:get/get.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';
import '../services/login_service.dart'; // 로그인 서비스를 추가합니다.
import '../services/message_service.dart';
import '../models/message.dart';

class MessageController extends GetxController {
  var friendID = 0.obs;// 친구 목록을 저장하는 RxList
  var isLoading = false.obs; // 로딩 상태를 나타내는 RxBool
  var messages = <Message>[]; // Message의 리스트로 messages를 정의

  MessageController(int friendID) {
    this.friendID.value = friendID;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMessageList(friendID.value);
  }

  Future<void> getMessageList(friendID) async {
    isLoading(true); // 로딩 상태를 true로 설정
    try {
      String? token = await getToken();
      print('토큰: $token'); // 로그인 서비스에서 토큰을 가져옵니다.
      if (token != null) {
        messages = await getMessageWithFriend(friendID, token);
      } else {
        print('토큰이 없습니다.');
      }
    } catch (e) {
      print('메시지 가져오기 실패: $e');
    } finally {
      isLoading(false); // 로딩 상태를 false로 설정
    }
  }
}