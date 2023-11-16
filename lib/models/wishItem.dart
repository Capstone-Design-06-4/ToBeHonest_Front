import 'package:hive/hive.dart';

part 'wishItem.g.dart';

@HiveType(typeId: 0)
class WishItem {
  @HiveField(0)
  final int wishItemId;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final double itemPrice;

  @HiveField(4)
  final double fundAmount;

  WishItem({
    required this.wishItemId,
    required this.itemName,
    required this.image,
    required this.itemPrice,
    required this.fundAmount,
  });

  factory WishItem.fromJson(Map<String, dynamic> json) {
    return WishItem(
      wishItemId: json['wishItemId'] as int,
      itemName: json['itemName'] as String,
      image: json['image'] as String,
      itemPrice: json['itemPrice'] as double,
      fundAmount: json['fundAmount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wishItemId': wishItemId,
      'itemName': itemName,
      'image': image,
      'itemPrice': itemPrice,
      'fundAmount': fundAmount,
    };
  }

  @override
  String toString() {
    return 'WishItem{'
        'wishItemId: $wishItemId, '
        'itemName: $itemName, '
        'image: $image, '
        'itemPrice: $itemPrice, '
        'fundAmount: $fundAmount}';
  }
}
