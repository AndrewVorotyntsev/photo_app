import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

/// Имплементация и реализация Виджет модели.
class PhotoListWM extends WidgetModel<PhotoListScreen, PhotoListModel>
    implements IPhotoListWM {
  /// Сущность хранящая список фото.
  final _photoListEntity = EntityStateNotifier<List<PhotoDto>>();

  /// Контроллер для списка фото.
  @override
  late ScrollController photoScrollController;

  /// Состояние списка фото.
  @override
  ListenableState<EntityState<List<PhotoDto>>> get photoListState =>
      _photoListEntity;

  PhotoListWM(PhotoListModel model) : super(model);

  @override
  Future<void> initWidgetModel() async {
    photoScrollController = ScrollController();
    photoScrollController.addListener(_photoScrollListener);
    await _loadPhoto();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    photoScrollController.dispose();
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
    final previousData = _photoListEntity.value?.data ?? [];
    _photoListEntity.loading(previousData);

    /// Генерируем моковые данные.
    // TODO(AndrewVorotyntsev): заменить на данные с сервера.
    final newPhoto = List.generate(
      10,
      (index) => PhotoDto(
        imageUrl:
            'https://images.unsplash.com/photo-1687392946857-96c2b7f94b0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwwfDF8YWxsfDJ8fHx8fHwyfHwxNjg3NDM2MjQ4fA&ixlib=rb-4.0.3&q=80&w=400',
        author: 'Author$index',
        likes: index,
        shadowColor: const Color(0xFF262673).withOpacity(0.7),
        blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
      ),
    );

    try {
      /// Имитируем задержку сервера.
      await Future.delayed(const Duration(seconds: 1), () {});
      final newList = List<PhotoDto>.from(previousData)..addAll(newPhoto);
      _photoListEntity.content(newList);
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
  ListenableState<EntityState<List<PhotoDto>>> get photoListState;

  /// Обработчик нажатия на карточку с фото.
  void onPhotoCardTap(PhotoDto photo);
}

PhotoListWM defaultAppWidgetModelFactory(BuildContext _) {
  return PhotoListWM(
    PhotoListModel(),
  );
}
