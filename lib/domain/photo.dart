import 'package:flutter/material.dart';

/// Доменная модель фотографии.
class Photo {
  /// Сссылка на изображение.
  final String imageUrl;

  /// Имя автора.
  final String author;

  /// Количество лайков.
  final int likes;

  /// Ассоциированный цвет тени.
  final Color shadowColor;

  /// Хэш блюра на основе фото.
  final String blurHash;

  Photo({
    required this.imageUrl,
    required this.author,
    required this.likes,
    required this.shadowColor,
    required this.blurHash,
  });
}
