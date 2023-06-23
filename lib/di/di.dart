import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:photo_app/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => getIt.init();
