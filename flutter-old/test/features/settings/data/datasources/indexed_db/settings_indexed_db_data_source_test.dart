import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart';
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart';
import 'package:mascot/features/settings/data/models/record_settings_model.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source_test.dart';

void main() {
  late TestIdbFactory indexedDbFactory;
  late SettingsIndexedDbDataSource dataSource;

  setUp(() async {
    indexedDbFactory = TestIdbFactory();
    dataSource = SettingsIndexedDbDataSource(
      indexedDbFactory,
      IndexDbSettings(),
    );

    Type testType = SettingsModel;
    await indexedDbFactory.factory!.deleteDatabase(testType.toString());
  });

  group('SettingsIndexedDbDataSource', () {
    group('fromJson', () {
      test('should return SettingsModel when provided with valid JSON', () {
        // arrange
        final recordSettingsJson = {
          'fps': 30,
          'holdToRecord': true,
          'delay': 3,
          'duration': 5,
        };
        final settingsJson = {
          'id': 1,
          'favoriteMascotId': 1,
          'talkingThresholdDecibels': -10.0,
          'recordSettings': recordSettingsJson,
        };

        // act
        final result = dataSource.fromJson(settingsJson);

        // assert
        expect(result, isA<SettingsModel>());
        expect(result.id, settingsJson['id']);
        expect(result.favoriteMascotId, settingsJson['favoriteMascotId']);
        expect(
          result.talkingThresholdDecibels,
          settingsJson['talkingThresholdDecibels'],
        );

        expect(result.recordSettings, isA<RecordSettingsModel>());
        expect(result.recordSettings.fps, equals(recordSettingsJson['fps']));
        expect(
          result.recordSettings.holdToRecord,
          equals(recordSettingsJson['holdToRecord']),
        );
        expect(
          result.recordSettings.delay.value,
          equals(recordSettingsJson['delay']),
        );
        expect(
          result.recordSettings.duration.value,
          equals(recordSettingsJson['duration']),
        );
      });
    });

    group('toJson', () {
      test('should return a JSON object from the provided SettingsModel', () {
        // arrange
        const settings = SettingsModel(
          id: 1,
          favoriteMascotId: 1,
          talkingThresholdDecibels: -10.0,
          recordSettings: RecordSettingsModel.empty,
        );

        // act
        final result = dataSource.toJson(settings);

        // assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], settings.id);
        expect(result['favoriteMascotId'], settings.favoriteMascotId);
        expect(
          result['talkingThresholdDecibels'],
          settings.talkingThresholdDecibels,
        );

        var recordSettings = result['recordSettings'];
        expect(recordSettings, isA<Map<String, dynamic>>());
        expect(recordSettings['fps'], equals(settings.recordSettings.fps));
        expect(
          recordSettings['holdToRecord'],
          equals(settings.recordSettings.holdToRecord),
        );
        expect(
          recordSettings['delay'],
          equals(settings.recordSettings.delay.value),
        );
        expect(
          recordSettings['duration'],
          equals(settings.recordSettings.duration.value),
        );
      });
    });

    group('getObject', () {
      test('should return existing SettingsModel when found', () async {
        // arrange
        const settings = SettingsModel(
          id: 1,
          favoriteMascotId: 1,
          talkingThresholdDecibels: -10.0,
          recordSettings: RecordSettingsModel.empty,
        );
        await dataSource.putObject(settings).single;

        // act
        final result = await dataSource.getObject(1).single;

        // assert
        expect(result, isA<SettingsModel>());
        expect(result.id, settings.id);
        expect(result.favoriteMascotId, settings.favoriteMascotId);
        expect(
          result.talkingThresholdDecibels,
          settings.talkingThresholdDecibels,
        );
      });

      test('should return and store empty SettingsModel when not found',
          () async {
        // arrange

        // act
        final result = await dataSource.getObject(1).single;

        // assert
        expect(result, isA<SettingsModel>());
        expect(result, SettingsModel.empty);
        final storedSettings = await dataSource.getObject(1).single;
        expect(storedSettings, SettingsModel.empty);
      });
    });
  });
}
