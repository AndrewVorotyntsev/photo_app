import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_app/di/di.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

void main() {
  configureDependencies();
  // Убираем цвет статус бара.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhotoListScreen(),
    );
  }
}
