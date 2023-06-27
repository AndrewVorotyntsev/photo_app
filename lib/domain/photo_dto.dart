import 'package:flutter/material.dart';

/// Доменная модель фотографии.
class PhotoDto {
  /// Изображение.
  final ImageProvider image;

  /// Имя автора.
  final String author;

  /// Количество лайков.
  final int likes;

  /// Ассоциированный цвет тени.
  final Color shadowColor;

  /// Хэш блюра на основе фото.
  final String? blurHash;

  PhotoDto({
    required this.image,
    required this.author,
    required this.likes,
    required this.shadowColor,
    this.blurHash,
  });
}
