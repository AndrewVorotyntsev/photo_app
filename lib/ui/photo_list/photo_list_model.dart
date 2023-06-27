import 'package:elementary/elementary.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';

/// Имплементация Elementary модели к Экрану списка фотографий.
class PhotoListModel extends ElementaryModel {
  final PhotoInteractor _photoInteractor;

  PhotoListModel(this._photoInteractor);

  Future<List<PhotoDto>> getPhoto() async {
    return _photoInteractor.getPhotos(page: 1);
  }
}
