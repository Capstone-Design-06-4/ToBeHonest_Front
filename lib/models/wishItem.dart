import 'package:hive/hive.dart';

part 'wishItem.g.dart';

@HiveType(typeId: 2)
class WishItem {
  @HiveField(0)
  final int wishItemId;

  @HiveField(1)
  final String itemBrand;

  @HiveField(2)
  final String itemName;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final int itemPrice;

  @HiveField(5)
  final int fundAmount;

  @HiveField(6)
  final int itemId;

  WishItem({
    required this.wishItemId,
    required this.itemBrand,
    required this.itemName,
    required this.image,
    required this.itemPrice,
    required this.fundAmount,
    required this.itemId,
  });

  factory WishItem.fromJson(Map<String, dynamic> json) {
    // itemName에서 HTML 태그 제거
    String rawItemName = json['itemName'] as String;
    String cleanedItemName = rawItemName.replaceAll(RegExp(r'<[/]?b>'), '');

    // itemName에서 브랜드 추출
    String itemBrand = cleanedItemName.split(' ').first;

    // 브랜드를 제거한 나머지 이름
    String itemName = cleanedItemName.substring(itemBrand.length).trim();
    return WishItem(
        wishItemId: json['wishItemId'] as int,
        itemBrand: itemBrand,
        itemName: itemName,
        image: json['image'] as String,
        itemPrice: json['itemPrice'] as int,
        fundAmount: json['fundAmount'] != null ? json['fundAmount'] as int : 0,
        itemId: json['itemId'] != null ? json['itemId'] as int : 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'wishItemId': wishItemId,
      'itemBrand': itemBrand, // 추가된 필드
      'itemName': '$itemBrand $itemName', // 원래 형식으로 복원
      'image': image,
      'itemPrice': itemPrice,
      'fundAmount': fundAmount,
      'itemId': itemId,
    };
  }

  @override
  String toString() {
    return 'WishItem{'
        'wishItemId: $wishItemId, '
        'itemBrand: $itemBrand, '
        'itemName: $itemName, '
        'image: $image, '
        'itemPrice: $itemPrice, '
        'fundAmount: $fundAmount'
        'itemId: $itemId}';
  }
}
