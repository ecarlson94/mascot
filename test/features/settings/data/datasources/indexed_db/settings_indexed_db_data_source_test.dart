import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart';
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart';
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
        final json = {
          'id': 1,
          'favoriteMascotId': 1,
          'talkingThresholdDecibels': -10.0,
        };

        // act
        final result = dataSource.fromJson(json);

        // assert
        expect(result, isA<SettingsModel>());
        expect(result.id, json['id']);
        expect(result.favoriteMascotId, json['favoriteMascotId']);
        expect(
          result.talkingThresholdDecibels,
          json['talkingThresholdDecibels'],
        );
      });
    });

    group('toJson', () {
      test('should return a JSON object from the provided SettingsModel', () {
        // arrange
        const settings = SettingsModel(
            id: 1, favoriteMascotId: 1, talkingThresholdDecibels: -10.0);

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
      });
    });

    group('getObject', () {
      test('should return existing SettingsModel when found', () async {
        // arrange
        const settings = SettingsModel(
          id: 1,
          favoriteMascotId: 1,
          talkingThresholdDecibels: -10.0,
        );
        await dataSource.putObject(settings);

        // act
        final result = await dataSource.getObject(1);

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
        final result = await dataSource.getObject(1);

        // assert
        expect(result, isA<SettingsModel>());
        expect(result, SettingsModel.empty);
        final storedSettings = await dataSource.getObject(1);
        expect(storedSettings, SettingsModel.empty);
      });
    });
  });
}
