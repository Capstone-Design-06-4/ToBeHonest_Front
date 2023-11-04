class Friend {
  final int id;
  final String name;
  final String birthDate;
  final String profileURL;
  final bool myGive;
  final bool myTake;

  Friend({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.profileURL,
    required this.myGive,
    required this.myTake,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['friendId'],
      name: json['specifiedName'],
      birthDate: json['birthDate'],
      profileURL: json['profileURL'],
      myGive: json['myGive'],
      myTake: json['myTake'],
    );
  }
}
