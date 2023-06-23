import 'package:injectable/injectable.dart';
import 'package:photo_app/api/photo/photo_api.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/models/photo/mapper/photo_mapper.dart';

/// Класс для логики работы с фото
abstract class PhotoInteractor {
  /// Получить список фото
  Future<List<Photo>> getPhotos({
    required int page,
  });
}

/// Имплементация к классу [PhotoInteractor]
@Injectable(as: PhotoInteractor)
class PhotoInteractorImpl implements PhotoInteractor {
  PhotoApi _photoApi;

  PhotoInteractorImpl(this._photoApi);

  @override
  Future<List<Photo>> getPhotos({required int page}) async {
    final photoResponse = await _photoApi.getPhotos(
      page: page,
      clientId: 'clientId',
    );
    final photoDomains = mapListPhoto(photoResponse);
    return photoDomains;
  }
}
