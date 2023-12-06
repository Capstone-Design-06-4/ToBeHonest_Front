import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';
import './message_service.dart';
import './login_service.dart';
import '../models/message.dart';
import '../models/wishItem.dart';
import 'package:tobehonest/services/url_manager.dart';

/*
 * contributeToFriend 메소드는 지정한 금액만큼 펀딩하고 축하메세지도 자동으로 전송함.
 *
 * 함수 파라미터
 * WishItem wishItem: 펀딩하려는 위시 아이템
 * int fundAmount: 사용자가 입력한 펀드 금액
 * int friendID: 친구의 friendID
 * String token: 로그인 토큰
 *
 *
 */

Future<http.Response> contributeToFriend(WishItem wishItem, int fundAmount,
    int friendID, String token) async {
  final url = Uri.parse('${UrlManager.baseUrl}contribution/${wishItem.wishItemId}/$fundAmount');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  //final body = json.encode({
  //  'fundAmount': fundAmount,
  //});

  try {
    //final response = await http.post(url, headers: headers, body: body);
    final response = await http.post(url, headers: headers);

    final String memberID = await getID() ?? '0';
    if(memberID == '0') throw Exception('다시 로그인해주세요.');

    Message message = Message(
        wishItemId: wishItem.wishItemId,
        senderId: int.parse(memberID),
        receiverId: friendID,
        title: wishItem.itemBrand + " " + wishItem.itemName,
        contents: '축하해요!',
        messageType: MessageType.CELEBRATION_MSG,
        fundMoney: fundAmount);
    await sendCelebrateMessage(message, token);
    if(response.statusCode == 200) print('펀딩이 성공적으로 전송되었습니다.');
    return response; // HTTP 응답 반환
  } catch (e) {
    print('오류 발생: $e');
    rethrow; // 예외를 다시 발생시켜 호출자에게 전달
  }
}