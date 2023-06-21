import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Абстракция Widget Model
abstract class IPhotoWidgetModel extends IWidgetModel {}

PhotoWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return PhotoWidgetModel(
    PhotoScreenModel(),
  );
}

/// Имплементация и реализация Виджет модели [IHomeUserProfileWidgetModel]
class PhotoWidgetModel extends WidgetModel<PhotoScreen, PhotoScreenModel>
    implements IPhotoWidgetModel {
  PhotoWidgetModel(PhotoScreenModel model) : super(model);
}
