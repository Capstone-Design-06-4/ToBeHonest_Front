import 'dart:io';

enum MessageType { THANKS_MSG, CELEBRATION_MSG }

class Message {
  final int wishItemId;
  final int senderId;
  final int receiverId;
  final String title;
  final String contents;
  final MessageType messageType;
  final int fundMoney;

  Message({
    required this.wishItemId,
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.contents,
    required this.messageType,
    required this.fundMoney
  });

  // Optionally, you can add a method to convert the instance to a Map or JSON,
  // if you plan to send the data over HTTP.
  Map<String, dynamic> toJson() {
    return {
      'wishItemId': wishItemId,
      'senderId': senderId,
      'receiverId': receiverId,
      'title': title,
      'contents': contents,
      'messageType': messageType.toString().split('.').last,
      'fundMoney': fundMoney,
    };
  }
}