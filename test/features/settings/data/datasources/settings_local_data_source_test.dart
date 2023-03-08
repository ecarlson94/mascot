import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsLocalDataSourceImpl dataSource;

  setUp(() {
    context = TestContext();
    dataSource = SettingsLocalDataSourceImpl(
      context.mocks.settingsCollectionAdapter,
    );
  });

  group('SettingsLocalDataSourceImpl', () {
    setUp(() {
      when(context.mocks.settingsCollectionAdapter.contains(any))
          .thenAnswer((_) async => true);
      when(context.mocks.settingsCollectionAdapter.get(any))
          .thenAnswer((_) async => context.data.settingsModel);
    });

    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // act
        final result = await dataSource.loadSettings();

        // assert
        expect(result, context.data.settingsModel);
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
        expect(result, context.data.settingsModel);
        verifyInOrder([
          context.mocks.settingsCollectionAdapter.contains(1),
          context.mocks.settingsCollectionAdapter
              .add(const SettingsModel(id: 1)),
          context.mocks.settingsCollectionAdapter.get(1)
        ]);
        verifyNoMoreInteractions(context.mocks.settingsCollectionAdapter);
      });
    });

    group('saveSettings', () {
      test('should add SettingsModel to local database', () async {
        // act
        await dataSource.saveSettings(context.data.settingsModel);

        // assert
        verify(context.mocks.settingsCollectionAdapter.add(
          context.data.settingsModel,
        ));
      });
    });

    group('streamSettings', () {
      test('should stream SettingsModel from local database', () async {
        // arrange
        var expectedStream = BehaviorSubject.seeded(context.data.settingsModel);
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
