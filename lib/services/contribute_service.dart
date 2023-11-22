import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';
import './message_service.dart';
import './login_service.dart';
import '../models/message.dart';
import '../models/wishItem.dart';

Future<void> contributeToFriend(WishItem wishItem, int fundAmount,
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

    if(response.statusCode == 200) {
      print('정상적으로 펀딩되었습니다.');
    } else {
      print('펀딩에 실패했습니다.');
    }
  }
  catch(e) {
    throw Exception('오류 발생: $e');
  }
}