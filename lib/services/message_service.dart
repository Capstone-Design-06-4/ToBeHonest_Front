import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:path/path.dart';

import '../models/message.dart'; // Ensure this is the correct import for your Message model

Future<http.Response> sendThanksMessage(Message message, io.File selectedImage, String token) async {
  final uri = Uri.parse('http://10.0.2.2:8080/message/send-thanks');

  try {
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = "Bearer $token"
      ..fields['wishItemId'] = message.wishItemId.toString()
      ..fields['senderId'] = message.senderId.toString()
      ..fields['receiverId'] = message.receiverId.toString()
      ..fields['title'] = message.title
      ..fields['contents'] = message.contents
      ..fields['messageType'] = message.messageType.toString().split('.').last
      ..fields['fundMoney'] = message.fundMoney.toString();

    var stream = http.ByteStream(selectedImage.openRead());
    var length = await selectedImage.length();
    var multipartFile = http.MultipartFile(
      'images', // Field name for files (as expected by server)
      stream,
      length,
      filename: basename(selectedImage.path),
    );

    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // Handle successful response
      return response;
    } else {
      // Handle non-200 responses
      // You can throw an exception or handle it in any other way you prefer
      throw Exception('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error sending message: $e');
    rethrow; // or you can return a custom response or handle the error differently
  }
}
