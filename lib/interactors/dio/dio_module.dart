import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Модуль для работы с Dio.
@module
abstract class DioModule {
  @lazySingleton
  Dio getDio() => Dio();
}
