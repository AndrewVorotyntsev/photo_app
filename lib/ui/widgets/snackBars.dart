import 'package:flutter/material.dart';
import 'package:photo_app/res/app_strings.dart';

/// Снэкьар для оповещения пользователя о том,
/// что не удалось загрузить данные
final errorLoadingSnackBar = SnackBar(
  backgroundColor: Colors.red[400],
  content: const Text(
    AppStrings.loadingError,
  ),
);
