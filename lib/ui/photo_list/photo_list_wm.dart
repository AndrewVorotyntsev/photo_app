import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoListWM extends WidgetModel<PhotoListScreen, PhotoListModel>
    implements IPhotoListWM {
  /// Сущность хранящая список фото.
  @override
  final EntityStateNotifier<List<PhotoDto>> photoListState =
      EntityStateNotifier<List<PhotoDto>>();

  /// Контроллер для списка фото.
  @override
  late ScrollController photoScrollController;

  PhotoListWM(PhotoListModel model) : super(model);

  @override
  Future<void> initWidgetModel() async {
    photoScrollController = ScrollController()
      ..addListener(_photoScrollListener);
    await _loadPhoto();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    photoScrollController.dispose();
    photoListState.dispose();
    super.dispose();
  }

  @override
  void onPhotoCardTap(PhotoDto photo) {
    Navigator.of(context).push(PhotoDetailsScreenRoute(photo: photo));
  }

  /// Обработчик скролла списка фото.
  void _photoScrollListener() {
    if (photoScrollController.position.extentAfter <= 0 &&
        photoListState.value?.isLoading != true) {
      _loadPhoto();
    }
  }

  Future<void> _loadPhoto() async {
    final previousData = photoListState.value?.data ?? [];
    photoListState.loading(previousData);

    try {
      final newPhotos = await model.getPhoto();
      photoListState.content([
        ...previousData,
        ...newPhotos,
      ]);
    } on Exception catch (e) {
      photoListState.error(e, previousData);
    }
  }
}

/// Абстракция Widget Model.
abstract class IPhotoListWM extends IWidgetModel {
  /// Контроллер для списка фото.
  ScrollController get photoScrollController;

  /// Состояние списка фото.
  ListenableState<EntityState<List<PhotoDto>>> get photoListState;

  /// Обработчик нажатия на карточку с фото.
  void onPhotoCardTap(PhotoDto photo);
}

PhotoListWM defaultAppWidgetModelFactory(BuildContext _) {
  return PhotoListWM(
    PhotoListModel(
      GetIt.I.get<PhotoInteractor>(),
    ),
  );
}
