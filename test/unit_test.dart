import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';
import 'package:photo_app/utils/color_util.dart';

import 'mock/photo/photo_interactor_mock.dart';

void main() {
  group('Interactor unit test', () {
    late final PhotoInteractor photoInteractor;
    late final List<PhotoDto> newPhotos;
    setUp(() {
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
        (_) => Future(() => newPhotos),
      );
    });

    test(
      'Photo list from interactor',
      () => expectLater(
        () async => photoInteractor.getPhotos(page: 1),
        returnsNormally,
      ),
    );
  });

  group('List model unit test', () {
    late final PhotoListModel photoListModel;
    setUp(() {
      photoListModel = PhotoListModel(PhotoInteractorMock());
    });

    test(
      'Photos from list model',
      () => expectLater(
        () async => photoListModel.getPhoto(page: 1),
        returnsNormally,
      ),
    );
  });

  group('Details model unit test', () {
    late final PhotoDetailsModel photoDetailsModel;
    late PhotoDto photo;
    setUp(() {
      photo = PhotoDto(
        imageUrl: '',
        author: 'Author',
        likes: 1,
        shadowColor: Colors.grey,
      );
      photoDetailsModel = PhotoDetailsModel(photo: photo);
    });

    test('Details photo from model', () async {
      expect(photoDetailsModel.photo, photo);
    });
  });

  group('Color Util Unit test', () {
    test('Convert hex format String to Material Color', () {
      const colorHexString = '#60544D';
      expect(ColorUtil.fromHex(colorHexString), const Color(0xFF60544D));
    });
  });
}
