import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/drift/mascot_database.dart';
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings.dart';
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotDatabase database;
  late SettingsDriftDataSource classUnderTest;

  late DriftSettings settingsModel;

  setUp(() {
    context = TestContext();
    database = context.database;
    classUnderTest = SettingsDriftDataSourceImpl(database);

    settingsModel = context.data.mapSettingsToSettingsModel.map(
      context.data.settings,
    );
  });

  group('SettingsDriftDataSourceImpl', () {
    group('saveSettings', () {
      test('should save settings', () async {
        // act
        await classUnderTest.saveSettings(settingsModel);

        // assert
        var savedSettings =
            await database.select(database.settings).getSingle();
        expect(savedSettings, equals(settingsModel));
      });
    });

    group('loadSettings', () {
      test('should load settings', () async {
        // arrange
        await classUnderTest.saveSettings(settingsModel);

        // act
        var loadedSettings = await classUnderTest.loadSettings();

        // assert
        expect(loadedSettings, equals(settingsModel));
      });

      test('should return default settings if none are saved', () async {
        // act
        var loadedSettings = await classUnderTest.loadSettings();

        // assert
        expect(loadedSettings, equals(DriftSettings.empty));
      });
    });

    group('streamSettings', () {
      test(
        'should emit DriftSettings when settings are updated',
        () async {
          // arrange
          var stream = classUnderTest.streamSettings();
          var expectedSettings = settingsModel.copyWith(
            favoriteMascotId: 22,
          );

          // act
          await classUnderTest.saveSettings(expectedSettings);

          // assert
          expect(stream, emits(expectedSettings));
        },
      );
    });
  });
}
