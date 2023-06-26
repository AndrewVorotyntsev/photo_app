import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:photo_app/di/di.dart';
import 'package:photo_app/interactors/photo/photo_interactor.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  _configureDependencies();
  return testMain();
}

void _configureDependencies() {
  getIt.registerSingleton<PhotoInteractor>(PhotoInteractorMock());
}
