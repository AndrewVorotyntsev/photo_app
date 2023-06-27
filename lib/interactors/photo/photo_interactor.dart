import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/api/photo/photo_api.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/models/photo/mapper/photo_mapper.dart';

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

/// [PhotoInteractor] без доступа к серверу.
class LocalPhotoInteractor implements PhotoInteractor {
  /// Захардкоженая ссылка на фото.
  static const _sampleImageUrl =
      'https://images.unsplash.com/photo-1687392946857-96c2b7f94b0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwwfDF8YWxsfDJ8fHx8fHwyfHwxNjg3NDM2MjQ4fA&ixlib=rb-4.0.3&q=80&w=400';

  /// Время задержки сервера.
  static const Duration _answerDelay = Duration(milliseconds: 400);

  /// Возвращает список одинковых фото,
  /// Ссылки на которые хранятся локально.
  @override
  Future<List<PhotoDto>> getPhotos({required int page}) async {
    /// Генерируем моковые данные.
    final newPhoto = List.generate(
      10,
      (index) => PhotoDto(
        imageUrl: _sampleImageUrl,
        author: 'Author$index',
        likes: index,
        shadowColor: const Color(0xFF262673).withOpacity(0.7),
        blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
      ),
    );

    /// Имитируем задержку сервера.
    await Future<void>.delayed(_answerDelay);

    return newPhoto;
  }
}
