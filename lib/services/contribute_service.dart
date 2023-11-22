import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';
import './message_service.dart';
import './login_service.dart';
import '../models/message.dart';
import '../models/wishItem.dart';

/*
 * contributeToFriend 메소드는 지정한 금액만큼 펀딩하고 축하메세지도 자동으로 전송함.
 *
 * 함수 파라미터
 * WishItem wishItem: 펀딩하려는 위시 아이템
 * int fundAmount: 사용자가 입력한 펀드 금액
 * int friendID: 친구의 friendID
 * String token: 로그인 토큰
 *
 * 사용 예시
 * 예를 들어, 사용자가 버튼을 눌렀을 때 이 함수가 호출됩니다.
void onContributeButtonPressed() async {
  try {
    final response = await contributeToFriend(wishItem, fundAmount, friendID, token);

    if (response.statusCode == 200) {
      // 성공적으로 처리되었을 때의 로직
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("성공"),
            content: Text("펀딩이 성공적으로 완료되었습니다."),
            actions: <Widget>[
              FlatButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop(); // 대화 상자 닫기
                },
              ),
            ],
          );
        },
      );
    } else {
      // 실패했을 때의 로직
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("실패"),
            content: Text("펀딩에 실패했습니다."),
            actions: <Widget>[
              FlatButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop(); // 대화 상자 닫기
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    // 오류 처리
    print('오류 발생: $e');
    // 필요한 경우 사용자에게 오류 메시지를 표시합니다.
  }
}
 *
 *
 */

Future<http.Response> contributeToFriend(WishItem wishItem, int fundAmount,
    int friendID, String token) async {
  final url = Uri.parse('http://localhost:8080/contribution/${wishItem.wishItemId}');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  final body = json.encode({
    'fundAmount': fundAmount,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

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
    if(response.statusCode == 200) print('메세지가 성공적으로 전송되었습니다.');
    return response; // HTTP 응답 반환
  } catch (e) {
    print('오류 발생: $e');
    rethrow; // 예외를 다시 발생시켜 호출자에게 전달
  }
}