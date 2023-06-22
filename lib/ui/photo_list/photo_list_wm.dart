import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoListWM extends WidgetModel<PhotoListScreen, PhotoListModel>
    implements IPhotoListWM {
  PhotoListWM(PhotoListModel model) : super(model);
}

// TODO(AndrewVorotyntsev): impement.
/// Абстракция Widget Model.
abstract class IPhotoListWM extends IWidgetModel {}

PhotoListWM defaultAppWidgetModelFactory(BuildContext _) {
  return PhotoListWM(
    PhotoListModel(),
  );
}
