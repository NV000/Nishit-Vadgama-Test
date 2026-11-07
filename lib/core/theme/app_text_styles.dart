import 'package:flutter/material.dart';

typedef AppTextStyle = AppTextStyles;

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
