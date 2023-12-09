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
  late String? itemImage;
  late List<String> messageImgURLs;

  Message({
    required this.wishItemId,
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.contents,
    required this.messageType,
    required this.fundMoney,
    this.itemImage,
    this.messageImgURLs = const [],
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    // messageType 문자열을 MessageType 열거형으로 변환
    MessageType parseMessageType(String type) {
      return MessageType.values.firstWhere(
            (e) => e.toString().split('.').last.toUpperCase() == type.toUpperCase(),
        orElse: () => MessageType.THANKS_MSG, // 기본값 설정
      );
    }

    return Message(
      wishItemId: json['wishItemId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      receiverId: json['receiverId'] ?? 0,
      title: json['messageTitle'] ?? '',
      contents: json['messageContents'] ?? '',
      messageType: parseMessageType(json['messageType'] ?? 'THANKS_MSG'),
      fundMoney: json['fundMoney'] ?? 0,
      itemImage: json['itemImage'] ?? '',
      messageImgURLs: List<String>.from(json['messageImgURLs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wishItemId': wishItemId,
      //'senderId': senderId,
      //'receiverId': receiverId,
      'title': title,
      'contents': contents,
      'messageType': messageType.toString().split('.').last,
      //'fundMoney': fundMoney,
      //'messageImgURLs': messageImgURLs,
    };
  }
}
