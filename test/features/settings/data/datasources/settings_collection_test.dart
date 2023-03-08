import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mascot/core/data/hive_collection_adapter.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/data/repositories/settings_collection.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

class IsarSettingsCollectionImpl extends IsarSettingsCollection {}

class HiveSettingsCollectionImpl extends HiveSettingsCollection {}

class SettingsCollectionAdapterImpl extends SettingsCollectionAdapter {}

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

void main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('IsarSettingsCollection', () {
    late IsarSettingsCollection isarSettingsCollection;
    late IsarCollection<SettingsModel> isarCollection;
    setUp(() {
      isarSettingsCollection = IsarSettingsCollectionImpl();
      isarCollection = MockIsarCollection<SettingsModel>();
    });

    test('should return isar collection', () {
      // arrange
      when(context.mocks.isar.collection<SettingsModel>())
          .thenReturn(isarCollection);

      // act
      final collection = isarSettingsCollection.create(context.mocks.isar);

      // assert
      expect(collection, isarCollection);
    });
  });

  group('HiveSettingsCollection', () {
    late HiveSettingsCollectionImpl hiveSettingsCollection;
    setUp(() {
      hiveSettingsCollection = HiveSettingsCollectionImpl();
      when(context.mocks.hiveInterface.openBox<SettingsModel>(any))
          .thenAnswer((_) async => context.mocks.hiveSettingsBox);
    });

    test('should open SettingsModel box for hive', () async {
      // act
      final box =
          await hiveSettingsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(
        context.mocks.hiveInterface.openBox<SettingsModel>('settings'),
      );
      expect(box, context.mocks.hiveSettingsBox);
    });

    test('should register SettingsModel adapter for hive', () async {
      // act
      await hiveSettingsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(
        context.mocks.hiveInterface.registerAdapter<SettingsModel>(
          SettingsModelAdapter(),
        ),
      );
    });
  });

  group('SettingsCollectionAdapter', () {
    late SettingsCollectionAdapter settingsCollectionAdapter;
    setUp(() {
      settingsCollectionAdapter = SettingsCollectionAdapterImpl();
    });

    test('should return hive collection', () {
      // act
      final collection = settingsCollectionAdapter.create(
        context.mocks.hiveSettingsBox,
      );

      // assert
      expect(collection, isA<HiveCollectionAdapter<SettingsModel>>());
    });
  });
}
