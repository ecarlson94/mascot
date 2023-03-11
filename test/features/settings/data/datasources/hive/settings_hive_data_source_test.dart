import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/hive_settings.dart';
import 'package:mascot/features/settings/data/datasources/hive/settings_hive_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsHiveDataSourceImpl dataSource;

  setUp(() {
    context = TestContext();
    dataSource = SettingsHiveDataSourceImpl(
      context.mocks.settingsCollectionAdapter,
      context.data.mapSettingsToHiveSettings,
    );
  });

  group('SettingsHiveDataSourceImpl', () {
    setUp(() {
      when(context.mocks.settingsCollectionAdapter.contains(any))
          .thenAnswer((_) async => true);
      when(context.mocks.settingsCollectionAdapter.get(any))
          .thenAnswer((_) async => context.data.hiveSettings);
    });

    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // act
        final result = await dataSource.loadSettings();

        // assert
        expect(result, context.data.hiveSettings);
        verify(context.mocks.settingsCollectionAdapter.get(1));
      });

      test('should create SettingsModel if one does not exist in the database',
          () async {
        // arrange
        when(context.mocks.settingsCollectionAdapter.contains(any))
            .thenAnswer((_) async => false);
        when(context.mocks.settingsCollectionAdapter.add(any))
            .thenAnswer((_) async => 1);

        // act
        final result = await dataSource.loadSettings();

        // assert
        expect(result, context.data.hiveSettings);
        verifyInOrder([
          context.mocks.settingsCollectionAdapter.contains(1),
          context.mocks.settingsCollectionAdapter.add(const HiveSettings()),
          context.mocks.settingsCollectionAdapter.get(1)
        ]);
        verifyNoMoreInteractions(context.mocks.settingsCollectionAdapter);
      });
    });

    group('saveSettings', () {
      test('should add SettingsModel to local database', () async {
        // act
        await dataSource.saveSettings(context.data.hiveSettings);

        // assert
        verify(context.mocks.settingsCollectionAdapter.add(
          context.data.hiveSettings,
        ));
      });
    });

    group('streamSettings', () {
      test('should stream SettingsModel from local database', () async {
        // arrange
        var expectedStream = BehaviorSubject.seeded(context.data.hiveSettings);
        when(context.mocks.settingsCollectionAdapter.stream(any))
            .thenAnswer((_) async => expectedStream);

        // act
        final result = await dataSource.streamSettings();

        // assert
        expect(result, expectedStream);
        verify(context.mocks.settingsCollectionAdapter.stream(1));
      });
    });
  });
}
