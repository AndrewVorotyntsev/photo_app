import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_app/di/di.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';

import 'mock/photo/photo_interactor_mock.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  _configureDependencies();
  return testMain();
}

void _configureDependencies() {
  final PhotoInteractor photoInteractor = PhotoInteractorMock();
  final newPhotos = List<PhotoDto>.generate(
    10,
    (index) => PhotoDto(
      imageUrl: '',
      author: 'Author$index',
      likes: index,
      shadowColor: const Color(0xFF262673).withOpacity(0.7),
      blurHash: 'LC7-g_NzImwHS#aHxJb|MtkanMs?',
    ),
  );
  when(
    () => photoInteractor.getPhotos(page: 1),
  ).thenAnswer(
    (_) => Future(() => newPhotos),
  );
  getIt.registerSingleton<PhotoInteractor>(PhotoInteractorMock());
}
