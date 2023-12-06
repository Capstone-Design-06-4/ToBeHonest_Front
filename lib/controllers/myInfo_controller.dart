import 'package:get/get.dart';
import 'package:tobehonest/models/myInfo.dart';
import 'package:tobehonest/services/login_service.dart';
import 'package:tobehonest/services/myInfo_service.dart';

class MyInfoController extends GetxController {
  var myInfo = MyInfo(
    name: '이름',
    profileURL: '프로필 URL',
    birthDate: DateTime.parse("2000-01-01"),
    myPoints: 1000,
    progressNum: 10,
    completedNum: 5,
    usedNoMsgNum: 3,
    usedMsgNum: 7,
  ).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchMyInfo();
  }

  Future<void> fetchMyInfo() async {
    String? token = await getToken();
    if(token == null) throw Exception('로그인 다시하세요.');
    myInfo.value = await getMyInfo(token);
    myInfo.refresh();
  }
// 필요한 경우 여기에 기타 로직 추가
}
