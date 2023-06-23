import 'package:elementary/elementary.dart';
import 'package:photo_app/domain/photo.dart';

/// Имплементация Elementary модели к экрану деталей фото.
class PhotoDetailsModel extends ElementaryModel {
  final Photo photo;
  PhotoDetailsModel({required this.photo});
}
