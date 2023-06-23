import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/domain/photo_dto.dart';

/// Класс для логики работы с фото.
abstract class PhotoInteractor {
  /// Получить список фото.
  Future<List<PhotoDto>> getPhotos({
    required int page,
  });
}

/// Мок к классу [PhotoInteractor].
@Injectable(as: PhotoInteractor)
class PhotoInteractorMock implements PhotoInteractor {
  PhotoInteractorMock();

  @override
  Future<List<PhotoDto>> getPhotos({required int page}) async {
    /// Генерируем моковые данные.
    final newPhoto = List.generate(
      10,
      (index) => PhotoDto(
        imageUrl:
            'https://images.unsplash.com/photo-1687392946857-96c2b7f94b0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwwfDF8YWxsfDJ8fHx8fHwyfHwxNjg3NDM2MjQ4fA&ixlib=rb-4.0.3&q=80&w=400',
        author: 'Author$index',
        likes: index,
        shadowColor: const Color(0xFF262673).withOpacity(0.7),
        blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
      ),
    );

    /// Имитируем задержку сервера.
    await Future.delayed(const Duration(seconds: 1), () {});

    return newPhoto;
  }
}
