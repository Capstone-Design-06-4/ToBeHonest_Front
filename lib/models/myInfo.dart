class MyInfo {
  final String name;
  final String profileURL;
  final DateTime birthDate;
  final int myPoints;
  final int progressNum;
  final int completedNum;
  final int usedNoMsgNum;
  final int usedMsgNum;

  MyInfo({
    required this.name,
    required this.profileURL,
    required this.birthDate,
    required this.myPoints,
    required this.progressNum,
    required this.completedNum,
    required this.usedNoMsgNum,
    required this.usedMsgNum,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      name: json['name'] as String,
      profileURL: json['profileURL'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      myPoints: json['myPoints'] as int,
      progressNum: json['progressNum'] as int,
      completedNum: json['completedNum'] as int,
      usedNoMsgNum: json['usedNoMsgNum'] as int,
      usedMsgNum: json['usedMsgNum'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profileURL': profileURL,
      'birthDate': birthDate.toIso8601String(),
      'myPoints': myPoints,
      'progressNum': progressNum,
      'completedNum': completedNum,
      'usedNoMsgNum': usedNoMsgNum,
      'usedMsgNum': usedMsgNum,
    };
  }
}
