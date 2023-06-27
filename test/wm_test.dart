import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_model.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_details/photo_details_wm.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_wm.dart';

void main() {
  late PhotoDto photo;

  setUp(() async {
    photo = PhotoDto(
      imageUrl: '',
      author: 'Author',
      likes: 1,
      shadowColor: Colors.grey,
    );
  });

  group('Test PhotoListWM', () {
    PhotoListWM setUpWm() {
      return PhotoListWM(
        PhotoListModel(
          PhotoInteractorMock(),
        ),
      );
    }

    test('Create PhotoListWM', () {
      expect(setUpWm, returnsNormally);
    });

    testWidgetModel<PhotoListWM, PhotoListScreen>(
      'Photo list state',
      setUpWm,
      (wm, tester, context) async {
        tester.init();
        expect(wm.photoListState.value?.isLoading, true);

        await Future<void>.delayed(const Duration(seconds: 1));

        expect(wm.photoListState.value?.isLoading, false);
      },
    );
  });

  group('Test PhotoDetailsWM', () {
    PhotoDetailsWM setUpWm() {
      return PhotoDetailsWM(
        PhotoDetailsModel(
          photo: photo,
        ),
      );
    }

    test('create PhotoDetailsWM', () {
      expect(setUpWm, returnsNormally);
    });

    testWidgetModel<PhotoDetailsWM, PhotoDetailsScreen>(
      'Photo Details WM attributes',
      setUpWm,
      (wm, tester, context) {
        tester.init();

        expect(wm.photo, photo);
        expect(wm.imageUrl, photo.imageUrl);
        expect(wm.likes, photo.likes);
      },
    );
  });
}
