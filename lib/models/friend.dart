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
// 예시 데이터를 만듭니다.
List<Friend> friends = [
  Friend(
    id: 1,
    name: 'Emily',
    birthDate: 'D-Day 0월 0일',
    profileURL: 'https://example.com/emily.jpg',
    myGive: true,
    myTake: false,
  ),
  Friend(
    id: 2,
    name: 'Brian',
    birthDate: 'D-1',
    profileURL: 'https://example.com/brian.jpg',
    myGive: false,
    myTake: true,
  ),
  Friend(
    id: 3,
    name: 'Nick',
    birthDate: 'D-3',
    profileURL: 'https://example.com/nick.jpg',
    myGive: true,
    myTake: true,
  ),
];
