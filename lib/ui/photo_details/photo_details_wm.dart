import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/ui/photo_details/photo_details_model.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoDetailsWM extends WidgetModel<PhotoDetailsScreen, PhotoDetailsModel>
    implements IPhotoDetailsWidgetModel {
  /// Данные о фото для отображения.
  @override
  PhotoDto get photo => model.photo;

  @override
  int get likes => model.photo.likes;

  @override
  String get imageUrl => model.photo.imageUrl;

  PhotoDetailsWM(PhotoDetailsModel model) : super(model);

  /// Действие по нажатию назад.
  @override
  void onBackTap() {
    Navigator.of(context).pop();
  }
}

abstract class IPhotoDetailsWidgetModel extends IWidgetModel {
  /// Данные о фото для отображения.
  PhotoDto get photo;

  /// Кол-во лайков.
  int get likes;

  /// Ссылка на изображение
  String get imageUrl;

  /// Действие по нажатию назад.
  void onBackTap();
}

PhotoDetailsWM defaultAppWidgetModelFactory(
  BuildContext _,
  PhotoDto photo,
) {
  return PhotoDetailsWM(
    PhotoDetailsModel(
      photo: photo,
    ),
  );
}
