import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';

import '../models/message.dart'; // Ensure this is the correct import for your Message model

Future<http.Response> sendThanksMessage(Message message, io.File selectedImage, String token) async {
  final uri = Uri.parse('http://10.0.2.2:8080/message/send-thanks');

  try {
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = "Bearer $token"
      ..fields['request'] = json.encode(message.toJson()); // JSON 데이터를 인코딩하여 추가

    var stream = http.ByteStream(selectedImage.openRead());
    var length = await selectedImage.length();
    var multipartFile = http.MultipartFile(
      'images', // 서버에서 기대하는 필드 이름
      stream,
      length,
      filename: basename(selectedImage.path),
    );

    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // 성공적인 응답 처리
      return response;
    } else {
      // 200이 아닌 응답 처리
      throw Exception('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // 요청 중 발생하는 예외 처리
    print('Error sending message: $e');
    rethrow; // 다시 예외 발생시키기
  }
}

Future<void> sendCelebrateMessage(Message message, String token) async {
  final url = Uri.parse('http://10.0.2.2:8080/message/send-celebrate');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  final body = json.encode({'request': message.toJson()});

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('메시지가 정상적으로 전송되었습니다.');
    } else {
      print('메시지 전송에 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('오류 발생: $e');
  }
}