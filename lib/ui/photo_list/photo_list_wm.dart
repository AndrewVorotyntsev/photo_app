import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoListWM extends WidgetModel<PhotoListScreen, PhotoListModel>
    implements IPhotoListWM {
  /// Сущность хранящая список фото.
  final _photoListEntity = EntityStateNotifier<List<Photo>>();

  /// Контроллер для списка фото.
  @override
  late ScrollController photoScrollController;

  /// Состояние списка фото.
  @override
  ListenableState<EntityState<List<Photo>>> get photoListState =>
      _photoListEntity;

  bool _isTotalLoaded = false;

  int _currentPage = 1;

  PhotoListWM(PhotoListModel model) : super(model);

  @override
  Future<void> initWidgetModel() async {
    photoScrollController = ScrollController();
    photoScrollController.addListener(_photoScrollListener);
    await _loadPhoto();
    super.initWidgetModel();
  }

  @override
  void onPhotoCardTap(Photo photo) {
    Navigator.of(context).push(PhotoDetailsScreenRoute(photo: photo));
  }

  /// Обработчик скролла списка фото.
  void _photoScrollListener() {
    if (photoScrollController.position.extentAfter <= 0 &&
        _isTotalLoaded != true &&
        photoListState.value?.isLoading != true) {
      _loadPhoto();
    }
  }

  Future<void> _loadPhoto() async {
    final previousData = _photoListEntity.value?.data ?? [];
    _photoListEntity.loading(previousData);

    try {
      /// Имитируем задержку сервера.
      final newPhotos = await model.getPhoto(page: _currentPage);
      if (newPhotos.isEmpty) {
        _isTotalLoaded = true;
      } else {
        final newList = List<Photo>.from(previousData)..addAll(newPhotos);
        _photoListEntity.content(newList);
        _currentPage++;
      }
    } on Exception catch (e) {
      _photoListEntity.error(e, previousData);
    }
  }
}

/// Абстракция Widget Model.
abstract class IPhotoListWM extends IWidgetModel {
  /// Контроллер для списка фото.
  ScrollController get photoScrollController;

  /// Состояние списка фото.
  ListenableState<EntityState<List<Photo>>> get photoListState;

  /// Обработчик нажатия на карточку с фото.
  void onPhotoCardTap(Photo photo);
}

PhotoListWM defaultAppWidgetModelFactory(BuildContext _) {
  return PhotoListWM(
    PhotoListModel(
      GetIt.I.get<PhotoInteractor>(),
    ),
  );
}
