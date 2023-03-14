import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mascot/core/data/hive/hive_collection_adapter.dart';
import 'package:mascot/features/mascot/data/datasources/hive/hive_mascots_collection.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/hive_mascot.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

class HiveMascotsCollectionImpl extends HiveMascotsCollection {}

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

class MascotsCollectionAdapterImpl extends MascotsCollectionAdapter {}

void main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('HiveMascotsCollection', () {
    late HiveMascotsCollection hiveMascotsCollection;
    setUp(() {
      hiveMascotsCollection = HiveMascotsCollectionImpl();
      when(context.mocks.hiveInterface.openBox<MascotModel>(any))
          .thenAnswer((_) async => context.mocks.hiveMascotBox);
    });

    test('should open MascotModel box for hive', () async {
      // act
      final box =
          await hiveMascotsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(context.mocks.hiveInterface.openBox<MascotModel>('mascots'));
      expect(box, context.mocks.hiveMascotBox);
    });

    test('should register MascotModel adapter for hive', () async {
      // act
      await hiveMascotsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(context.mocks.hiveInterface.registerAdapter(HiveMascotAdapter()));
    });
  });

  group('MascotsCollectionAdapter', () {
    late MascotsCollectionAdapter adapter;
    setUp(() {
      adapter = MascotsCollectionAdapterImpl();
    });

    test('should return HiveCollectionAdapter', () {
      // act
      final result = adapter.create(context.mocks.hiveMascotBox);

      // assert
      expect(result, isA<HiveCollectionAdapter<HiveMascot>>());
    });
  });
}
