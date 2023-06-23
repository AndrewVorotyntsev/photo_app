import 'package:flutter/material.dart';

// Расшиение для работы с цветом.
extension ColorUtil on Color {
  /// Получить цвет на основе hex строки.
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
