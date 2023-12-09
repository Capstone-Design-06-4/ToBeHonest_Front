// friend.dart
import 'package:hive/hive.dart';

// By below command in terminal
// Hive generator will generate a 'friend.g.dart' file
// flutter packages pub run build_runner build
part 'friend.g.dart';

@HiveType(typeId: 0) // typeId는 Hive 박스에서 이 모델을 식별하는 데 사용됩니다.
class Friend extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String birthDate;

  @HiveField(3)
  final String profileURL;

  @HiveField(4)
  final bool myGive;

  @HiveField(5)
  final bool myTake;

  Friend({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.profileURL,
    required this.myGive,
    required this.myTake,
  });

  // JSON 맵에서 Friend 객체를 생성하는 팩토리 생성자
  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['friendId'] is int ? json['friendId'] : int.tryParse(json['friendId'].toString()) ?? 0,
      name: json['specifiedName'],
      birthDate: json['birthDate'],
      profileURL: json['profileURL'],
      myGive: json['myGive'],
      myTake: json['myTake'],
    );
  }

  // Friend 객체를 문자열로 변환하는 toString 메소드
  @override
  String toString() {
    return 'Friend{id: $id, name: $name, birthDate: $birthDate, profileURL: $profileURL, myGive: $myGive, myTake: $myTake}';
  }
}
