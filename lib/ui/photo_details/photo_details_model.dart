import 'package:elementary/elementary.dart';
import 'package:photo_app/domain/photo_dto.dart';

/// Имплементация Elementary модели к экрану деталей фото.
class PhotoDetailsModel extends ElementaryModel {
  final PhotoDto photo;
  PhotoDetailsModel({required this.photo});
}
