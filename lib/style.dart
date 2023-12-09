import 'package:flutter/material.dart';

class AppColor extends Color {
  AppColor(super.value);

  static const backgroundColor = Color(0xFFF4A261);
  static const textColor = Color(0xFFFF9A00);
  static const objectColor = Color(0xFFFE6C35);
  static const subColor = Color(0xFFFFA87F);
  static const swatchColor = Color(0xFFFDA062);

  // 인덱스가 클수록 어두운 색
  static const List<Color> colorList = [
    Color(0xFFFFA87F),
    Color(0xFFF4A261),
    Color(0xFFFDA062),
    Color(0xFFFF9A00),
    Color(0xFFFE6C35),

  ];
}
