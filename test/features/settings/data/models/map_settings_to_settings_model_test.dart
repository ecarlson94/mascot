import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/settings/data/models/map_settings_to_settings_model.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  group('MapSettingsToSettingsModel', () {
    late TestContext context;
    late MapSettingsToSettingsModel mapSettingsToSettingsModel;
    setUp(() {
      context = TestContext();
      mapSettingsToSettingsModel = MapSettingsToSettingsModel();
    });

    test('should return a SettingsModel when the input is valid', () {
      // arrange
      var expectedSettingsModel = context.data.settingsModel;
      var inputSettings = context.data.settings;

      // act
      final result = mapSettingsToSettingsModel(inputSettings);

      // assert
      expect(result, expectedSettingsModel);
    });

    test('reverse should return a Settings when the input is valid', () {
      // arrange
      var expectedSettings = context.data.settings;
      var inputSettingsModel = context.data.settingsModel;

      // act
      final result = mapSettingsToSettingsModel.reverse(inputSettingsModel);

      // assert
      expect(result, expectedSettings);
    });
  });
}
