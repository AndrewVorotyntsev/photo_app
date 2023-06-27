import 'package:flutter/material.dart';

class AppTextStyles {
  static const String manropeFontName = 'Manrope';

  static const Color _blackTextColor = Colors.black;
  static const Color _whiteTextColor = Colors.white;

  static TextStyle expandedAppbarTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: _blackTextColor,
  );

  static TextStyle collapsedAppbarTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: _blackTextColor,
  );

  static TextStyle cardTitleTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: _whiteTextColor,
  );

  static TextStyle cardSubtitleTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: _whiteTextColor,
  );

  static TextStyle backButtonTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: _whiteTextColor,
  );

  static TextStyle authorNameTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: _blackTextColor,
  );

  static TextStyle likesTextStyle = const TextStyle(
    fontFamily: manropeFontName,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: _blackTextColor,
  );
}
