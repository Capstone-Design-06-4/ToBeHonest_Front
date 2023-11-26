//friend_controller.dart

import 'package:get/get.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';
import '../services/login_service.dart'; // 로그인 서비스를 추가합니다.

class FriendController extends GetxController {
  var friendsList = <Friend>[].obs; // 친구 목록을 저장하는 RxList
  var isLoading = false.obs; // 로딩 상태를 나타내는 RxBool

  // 친구 목록을 가져오는 메소드
  Future<void> getFriendsList() async {
    isLoading(true); // 로딩 상태를 true로 설정
    try {
      String? token = await getToken();
      print('토큰: $token');// 로그인 서비스에서 토큰을 가져옵니다.
      if (token != null) {
        await fetchFriends(token);
        var friends = await getAllFriends(); // 서비스에서 친구 목록을 가져옵니다.
        if (friends.isNotEmpty) {
          friendsList.assignAll(friends);
        }
      } else {
        print('토큰이 없습니다.');
      }
      friendsList.refresh();
    } catch (e) {
      print('친구 목록을 가져오는 데 실패했습니다: $e');
    } finally {
      isLoading(false); // 로딩 상태를 false로 설정
    }
  }

  var isAddingAllowed = true.obs; // 친구 추가 가능 여부를 결정하는 상태 변수

  // 검색 쿼리를 실행하는 메소드
  void searchFriends(String searchQuery) async {
    isLoading(true); // 검색 시작 시 로딩 상태 활성화
    try {
      String? token = await getToken(); // 로그인 서비스에서 토큰을 가져옵니다.
      if (token == null) throw Exception("토큰이 없습니다."); // 토큰 없음 예외 처리

      var results = await searchAndRetrieveFriends(
          searchQuery, token); // 서비스에서 검색 결과를 가져옵니다.
      if (results.isEmpty) {
        // 결과가 없으면 적절한 UI 업데이트를 수행합니다.
        // 예를 들어, 사용자에게 결과가 없음을 알리는 메시지를 보여줄 수 있습니다.
        friendsList.clear();
      } else {
        friendsList.assignAll(results); // 결과가 있을 경우 리스트를 업데이트
      }
    } catch (e, stacktrace) {
      // 예외 발생 시 콘솔에 로그를 남깁니다.
      print('친구를 검색하는 데 실패했습니다: $e');
      print('스택 트레이스: $stacktrace');
      // 여기에 UI를 업데이트하는 코드를 추가할 수 있습니다.
      // 예를 들어, 에러 메시지를 표시하는 다이얼로그를 띄울 수 있습니다.
    } finally {
      isLoading(false); // 작업 완료 시 로딩 상태 해제
    }
  }
}