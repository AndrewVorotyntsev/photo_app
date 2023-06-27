import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/api/photo/photo_api.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/models/photo/mapper/photo_mapper.dart';
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

/// Имплементация к классу [PhotoInteractor].
@Injectable(as: PhotoInteractor)
class PhotoInteractorImpl implements PhotoInteractor {
  final PhotoApi _photoApi;

  PhotoInteractorImpl(this._photoApi);

  @override
  Future<List<PhotoDto>> getPhotos({required int page}) async {
    try {
      final photoResponse = await _photoApi.getPhotos(
        page: page,
        // TODO(AndrewVorotyntsev): указать АПИ Ключ.
        clientId: 'clientId',
      );
      final photoDomains = mapListPhoto(photoResponse);
      return photoDomains;
    } on DioException catch (e) {
      // Если дошли до конца возвращаем пустой список,
      // как маркер что данные закончились.
      // Код 403 означает, что доступ к данным ограничен.
      if (e.response?.statusCode == 403) {
        return [];
      }
      rethrow;
    }
  }
}

/// Мок к классу [PhotoInteractor].
class PhotoInteractorMock implements PhotoInteractor {
  PhotoInteractorMock();

  @override
  Future<List<PhotoDto>> getPhotos({required int page}) async {
    /// Генерируем моковые данные.
    final newPhoto = List.generate(
      10,
      (index) => PhotoDto(
        imageUrl: '',
        author: 'Author$index',
        likes: index,
        shadowColor: const Color(0xFF262673).withOpacity(0.7),
        blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
      ),
    );

    /// Имитируем задержку сервера.
    await Future<void>.delayed(const Duration(seconds: 1));

    return newPhoto;
  }
}
