import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_model.dart';
import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_details/photo_details_wm.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_wm.dart';

import 'mock/photo/photo_interactor_mock.dart';

void main() {
  late PhotoDto photo;
  late PhotoInteractor photoInteractor;
  late List<PhotoDto> newPhotos;
  const answerDelay = Duration(milliseconds: 400);

  setUp(() async {
    photo = PhotoDto(
      imageUrl: '',
      author: 'Author',
      likes: 1,
      shadowColor: Colors.grey,
    );

    newPhotos = List.generate(
      10,
      (index) => PhotoDto(
        imageUrl: '',
        author: 'Author$index',
        likes: index,
        shadowColor: const Color(0xFF262673).withOpacity(0.7),
        blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
      ),
    );

    photoInteractor = PhotoInteractorMock();

    when(
      () => photoInteractor.getPhotos(page: 1),
    ).thenAnswer(
      (_) => Future.delayed(answerDelay, () => newPhotos),
    );
  });

  group('Test PhotoListWM', () {
    PhotoListWM setUpWm() {
      return PhotoListWM(
        PhotoListModel(
          photoInteractor,
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

        await Future<void>.delayed(answerDelay);

        expect(wm.photoListState.value?.isLoading, false);
        expect(wm.photoListState.value?.error, null);
        expect(wm.photoListState.value?.data, newPhotos);
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
