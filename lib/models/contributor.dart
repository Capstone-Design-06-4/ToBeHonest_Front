import 'package:hive/hive.dart';
import '../services/friend_service.dart';
import '../models/friend.dart';

part 'contributor.g.dart';

@HiveType(typeId: 3)
class Contributor {
  @HiveField(0)
  final int wishItemID;

  @HiveField(1)
  final int friendID;

  @HiveField(2)
  final String friendName;

  @HiveField(3)
  final String ProfileURL;

  @HiveField(4)
  final int contribution;

  Contributor({
    required this.wishItemID,
    required this.friendID,
    required this.friendName,
    required this.ProfileURL,
    required this.contribution,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(wishItemID: json['wishItemId'] as int,
        friendID: json['friendId'] as int,
        friendName: json['friendName'] as String,
        ProfileURL:json['profileImg'] as String ?? "default.png",
        contribution: json['contribution'] != null ? json['contribution'] as int : 0,
    );
  }

  @override
  String toString() {
    return 'Contributor('
        'wishItemID: $wishItemID, '
        'friendID: $friendID, '
        'friendName: $friendName, '
        'ProfileURL: $ProfileURL, '
        'contribution: $contribution)';
  }
}