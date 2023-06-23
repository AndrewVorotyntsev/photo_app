import 'package:elementary/elementary.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';

/// Имплементация Elementary модели к Экрану списка фотографий.
class PhotoListModel extends ElementaryModel {
  PhotoInteractor photoInteractor;

  PhotoListModel(this.photoInteractor);

  Future<List<Photo>> getPhoto({required int page}) async {
    return photoInteractor.getPhotos(page: page);
  }
}
