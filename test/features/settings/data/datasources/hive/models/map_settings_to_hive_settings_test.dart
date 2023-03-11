import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/map_settings_to_hive_settings.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  group('MapSettingsToHiveSettings', () {
    late TestContext context;
    late MapSettingsToHiveSettings mapSettingsToSettingsModel;
    setUp(() {
      context = TestContext();
      mapSettingsToSettingsModel = MapSettingsToHiveSettings();
    });

    test('should return a SettingsModel when the input is valid', () {
      // arrange
      var expectedSettingsModel = context.data.hiveSettings;
      var inputSettings = context.data.settings;

      // act
      final result = mapSettingsToSettingsModel.map(inputSettings);

      // assert
      expect(result, expectedSettingsModel);
    });

    test('reverse should return a Settings when the input is valid', () {
      // arrange
      var expectedSettings = context.data.settings;
      var inputSettingsModel = context.data.hiveSettings;

      // act
      final result = mapSettingsToSettingsModel.reverse(inputSettingsModel);

      // assert
      expect(result, expectedSettings);
    });
  });
}
