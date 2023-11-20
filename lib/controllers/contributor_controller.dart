//contributor_controller.dart

import 'package:get/get.dart';
import '../models/contributor.dart';
import '../services/contributor_service.dart';
import '../services/login_service.dart';

class ContributorController extends GetxController {
  var ContributorList = <Contributor>[].obs; // 친구 목록을 저장하는 RxList
  var isLoading = false.obs; // 로딩 상태를 나타내는 RxBool

  Future<void> getContributorList(int wishItemID) async {
    isLoading(true); // 로딩 상태를 true로 설정
    try {
      String? token = await getToken(); // 로그인 서비스에서 토큰을 가져옵니다.
      if (token != null) {
        List<Contributor> contributors = await getAllContributors(); // 로컬 저장소에서 후원자 목록을 가져옵니다.

        // 디버깅을 위한 print 문 추가
        print('Local Contributors: $contributors');

        if (contributors.isNotEmpty) {
          await fetchContributorByWishItemID(wishItemID, token); // RxList에 후원자 목록을 할당합니다.
        }
      } else {
        print('토큰이 없습니다.');
      }
    } catch (e) {
      print('후원자 목록을 가져오는 데 실패했습니다: $e');
    } finally {
      isLoading(false); // 로딩 상태를 false로 설정
    }
  }
}
