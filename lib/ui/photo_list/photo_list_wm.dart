import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoListWM extends WidgetModel<PhotoListScreen, PhotoListModel>
    implements IPhotoListWM {
  /// Сущность хранящая список фото.
  @override
  final EntityStateNotifier<List<Photo>> photoListState =
      EntityStateNotifier<List<Photo>>();

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
  void onPhotoCardTap(int id) {
    // TODO(AndrewVorotyntsev): переход к деталям фото.
  }

  /// Обработчик скролла списка фото.
  void _photoScrollListener() {
    if (photoScrollController.position.extentAfter <= 0) {
      _loadPhoto();
    }
  }

  Future<void> _loadPhoto() async {
    final previousData = photoListState.value?.data ?? [];
    photoListState.loading(previousData);

    /// Генерируем моковые данные.
    // TODO(AndrewVorotyntsev): заменить на данные с сервера.
    final newPhoto = List.generate(
      10,
      (index) => Photo(
        imageUrl:
            'https://images.unsplash.com/photo-1687392946857-96c2b7f94b0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwwfDF8YWxsfDJ8fHx8fHwyfHwxNjg3NDM2MjQ4fA&ixlib=rb-4.0.3&q=80&w=400',
        author: 'Author$index',
        likes: index,
      ),
    );

    try {
      /// Имитируем задержку сервера.
      await Future.delayed(const Duration(seconds: 1), () {});
      final newList = List<Photo>.from(previousData)..addAll(newPhoto);
      photoListState.content(newList);
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
  ListenableState<EntityState<List<Photo>>> get photoListState;

  /// Обработчик нажатия на карточку с фото.
  void onPhotoCardTap(int id);
}

PhotoListWM defaultAppWidgetModelFactory(BuildContext _) {
  return PhotoListWM(
    PhotoListModel(),
  );
}
