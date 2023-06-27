import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:photo_app/domain/photo_dto.dart';

import 'package:photo_app/ui/photo_details/photo_details_screen.dart';
import 'package:photo_app/ui/photo_list/photo_list_screen.dart';

void main() {
  late PhotoDto photo;

  setUp(() {
    photo = PhotoDto(
      image: AssetImage('assets/default_photo.jpeg'),
      author: 'Author',
      likes: 1,
      shadowColor: Colors.grey,
    );
  });

  testGoldens('List', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
        ],
      )
      ..addScenario(
        widget: const PhotoListScreen(),
        name: 'list',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'photo_list');
  });

  testGoldens('Details', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
        ],
      )
      ..addScenario(
        widget: PhotoDetailsScreen(photo),
        name: 'photo_details',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'photo_details');
  });
}
