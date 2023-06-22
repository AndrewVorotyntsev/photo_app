import 'package:flutter/material.dart';

class AppTextStyles {
  static const String manropeFontName = 'Manrope';

  static TextStyle expandedAppbarTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: Colors.black,
  );

  static TextStyle collapsedAppbarTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.black,
  );

  static TextStyle cardTitleTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: Colors.white,
  );

  static TextStyle cardSubtitleTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Colors.white,
  );
}