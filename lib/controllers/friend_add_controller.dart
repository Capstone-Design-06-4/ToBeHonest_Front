import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';
import '../services/login_service.dart';

class AddController extends GetxController {
  var currentUserEmail = '';
  var friendsList = <Friend>[].obs;

  Future<Tuple2<Friend, String>> searchFriendsByEmail(String searchQuery) async {
    print('searchFriendsByEmail 시작: $searchQuery');

    try {
      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      Tuple2<Friend, String> results =
      await findFriendByEmail(searchQuery, token);
      print('검색 결과: ${results.item1}');

      switch (results.item2) {
        case 'EMPTY':
          print('EMPTY: 데이터베이스에 해당 사용자가 없음');

          break;
        case 'ME':
          print('ME: 검색 결과가 현재 사용자와 일치함');

          break;
        case 'FRIEND':
          print('FRIEND: 이미 친구 목록에 있는 사람');

          break;
        case 'NOT_FRIEND':
          print('검색된 친구 정보: ${results.item1.name}');

          addFriend(results.item1.id.toString(), token);
          break;
        default:
          print('UNKNOWN: 알 수 없는 오류 발생');
          break;
      }

      return results;
    } catch (e) {
      print('친구를 검색하는 데 실패했습니다: $e');
      throw e; // 예외를 호출자에게 다시 던집니다.
    } finally {
      print('searchFriendsByEmail 종료');
    }
  }

  Future<Tuple2<Friend, String>> searchFriendsByNumber(String searchQuery) async {
    print('searchFriendsByNumber 시작: $searchQuery');

    try {
      String? token = await getToken();
      print('토큰: $token');
      if (token == null) throw Exception("토큰이 없습니다.");

      Tuple2<Friend, String> results =
      await findFriendByPhone(searchQuery, token);
      print('검색 결과: ${results.item1}');

      switch (results.item2) {
        case 'EMPTY':
          print('EMPTY: 데이터베이스에 해당 사용자가 없음');
          Get.snackbar("알림", "등록되지 않은 사용자입니다.",
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 1),);
          break;
        case 'ME':
          print('ME: 검색 결과가 현재 사용자와 일치함');
          Get.snackbar("알림", "본인의 전화번호를 입력하셨습니다.",
              snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 1),);
          break;
        case 'FRIEND':
          print('FRIEND: 이미 친구 목록에 있는 사람');
          Get.snackbar("알림", "이미 친구목록에 있는 사용자입니다.",
              snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 1),);
          break;
        case 'NOT_FRIEND':
          print('검색된 친구 정보: ${results.item1.name}');
          Get.snackbar("알림", "친구 추가가 완료되었습니다.",
              snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 1),);
          addFriend(results.item1.id.toString(), token);
          break;
        default:
          print('UNKNOWN: 알 수 없는 오류 발생');
          break;
      }

      return results;
    } catch (e) {
      print('친구를 검색하는 데 실패했습니다: $e');
      throw e; // 예외를 호출자에게 다시 던집니다.
    } finally {
      print('searchFriendsByNumber 종료');
    }
  }
}
