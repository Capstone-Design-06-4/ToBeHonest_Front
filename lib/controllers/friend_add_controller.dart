import 'package:get/get.dart';
import 'package:tuple/tuple.dart'; // Tuple을 사용하기 위한 import
import '../models/friend.dart'; // Friend 모델 import
import '../services/friend_service.dart'; // 친구 관련 서비스 import
import '../services/login_service.dart'; // 로그인 관련 서비스 import

class AddController extends GetxController {
  var currentUserEmail = ''; // 현재 사용자의 이메일을 저장하는 변수
  var friendsList = <Friend>[].obs; // 현재 친구 목록을 저장하는 변수 (RxList)

  // 이메일을 이용하여 친구 검색 메서드
  void searchFriendsByEmail(String searchQuery) async {
    print('searchFriendsByEmail 시작: $searchQuery'); // 메서드 시작 로그 출력

    try {
      String? token = await getToken(); // 사용자 토큰을 얻음
      print('토큰: $token'); // 토큰 로그 출력
      if (token == null) throw Exception("토큰이 없습니다."); // 토큰이 없으면 예외 발생

      // 이메일을 통해 친구를 검색하고 검색 결과를 받아옴
      Tuple2<Friend, String> results = await findFriendByEmail(
          searchQuery, token);
      print('검색 결과: ${results.item1}'); // 검색 결과 상태 로그 출력

      // 검색 결과 상태에 따라 처리
      switch (results.item2) {
        case 'EMPTY':
          print('EMPTY: 데이터베이스에 해당 사용자가 없음'); // 데이터베이스에 해당 사용자 없음
        case 'ME':
          print('ME: 검색 결과가 현재 사용자와 일치함'); // 검색 결과가 현재 사용자와 일치함
        case 'FRIEND':
            print('FRIEND: 이미 친구 목록에 있는 사람'); // 이미 친구 목록에 있는 사람
        case 'NOT_FRIEND':
            print('검색된 친구 정보: ${results.item1.name}');
            addFriend(results.item1.id.toString(), token);// 검색된 친구 정보 출력
        default:
          print('UNKNOWN: 알 수 없는 오류 발생'); // 알 수 없는 오류 발생
      }
    } catch (e) {
      print('친구를 검색하는 데 실패했습니다: $e'); // 친구 검색 실패
    } finally {
      print('searchFriendsByEmail 종료'); // 메서드 종료 로그 출력
    }
  }

  void searchFriendsByNumber(String searchQuery) async {
    print('searchFriendsByNumber 시작: $searchQuery'); // 메서드 시작 로그 출력

    try {
      String? token = await getToken(); // 사용자 토큰을 얻음
      print('토큰: $token'); // 토큰 로그 출력
      if (token == null) throw Exception("토큰이 없습니다."); // 토큰이 없으면 예외 발생

      // 이메일을 통해 친구를 검색하고 검색 결과를 받아옴
      Tuple2<Friend, String> results = await findFriendByPhone(
          searchQuery, token);
      print('검색 결과: ${results.item1}'); // 검색 결과 상태 로그 출력

      // 검색 결과 상태에 따라 처리
      switch (results.item2) {
        case 'EMPTY':
          print('EMPTY: 데이터베이스에 해당 사용자가 없음');
          Get.snackbar(
              "알림", "등록되지 않은 사용자입니다.", snackPosition: SnackPosition.TOP);// 데이터베이스에 해당 사용자 없음
        case 'ME':
          print('ME: 검색 결과가 현재 사용자와 일치함'); // 검색 결과가 현재 사용자와 일치함
          Get.snackbar(
              "알림", "본인의 전화번호를 입력하셨습니다.", snackPosition: SnackPosition.TOP);// 데이터베이스에 해당 사용자 없음
        case 'FRIEND':
          print('FRIEND: 이미 친구 목록에 있는 사람'); // 이미 친구 목록에 있는 사람
          Get.snackbar(
              "알림", "이미 친구 목록에 있는 정보입니다.", snackPosition: SnackPosition.TOP);// 데이터베이스에 해당 사용자 없음
        case 'NOT_FRIEND':
          print('검색된 친구 정보: ${results.item1.name}');
          Get.snackbar(
              "알림", "친구 추가가 완료되었습니다.", snackPosition: SnackPosition.TOP);// 데이터베이스에 해당 사용자 없음
          addFriend(results.item1.id.toString(), token);// 검색된 친구 정보 출력
        default:
          print('UNKNOWN: 알 수 없는 오류 발생'); // 알 수 없는 오류 발생
      }
    } catch (e) {
      print('친구를 검색하는 데 실패했습니다: $e'); // 친구 검색 실패
    } finally {
      print('searchFriendsByEmail 종료'); // 메서드 종료 로그 출력
    }
  }
}