  //friend_add_controller.dart

  import 'package:get/get.dart';
  import 'package:tuple/tuple.dart';
  import '../models/friend.dart';
  import '../services/friend_service.dart';
  import '../services/login_service.dart';

  class AddController extends GetxController {
    var isAdding = false.obs; // 로딩 상태를 나타내는 RxBool
    var currentUserEmail = ''; // 현재 사용자의 이메일을 저장하는 변수
    var friendsList = <Friend>[].obs; // 현재 친구 목록을 나타내는 RxList

    void searchFriendsByEmail(String searchQuery) async {
      print('searchFriendsByEmail 시작: $searchQuery'); // 메서드 시작 로그
      isAdding(true);
      try {
        String? token = await getToken();
        print('토큰: $token'); // 토큰 로그
        if (token == null) throw Exception("토큰이 없습니다.");

        Tuple2<Friend, String> results = await findFriendByEmail(searchQuery, token);
        print('검색 결과: ${results.item2}'); // 검색 결과 상태 로그

        switch (results.item2) {
          case 'EMPTY':
            print('EMPTY: 데이터베이스에 해당 사용자가 없음');
            break;
          case 'SUCCESS':
            print('SUCCESS: 검색 성공');
            if (searchQuery == currentUserEmail) {
              print('ME: 검색 결과가 현재 사용자와 일치함');
            } else if (friendsList.any((friend) => friend.id == results.item1.id)) {
              print('FRIEND: 이미 친구 목록에 있는 사람');
            } else {
              print('검색된 친구 정보: ${results.item1.name}');
            }
            break;
          case 'ERROR':
            print('ERROR: 서버 오류 발생');
            break;
          default:
            print('UNKNOWN: 알 수 없는 오류 발생');
        }
      } catch (e) {
        print('친구를 검색하는 데 실패했습니다: $e');
      } finally {
        isAdding(false);
        print('searchFriendsByEmail 종료'); // 메서드 종료 로그
      }
    }
  }
