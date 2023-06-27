import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';
import 'package:photo_app/ui/photo_details/photo_details_model.dart';
import 'package:photo_app/ui/photo_list/photo_list_model.dart';

void main() {
  group('Interactor unit test', () {
    late final PhotoInteractor photoInteractor;
    setUp(() {
      photoInteractor = PhotoInteractorMock();
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
}
