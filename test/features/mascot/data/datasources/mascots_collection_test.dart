import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mascot/features/mascot/data/datasources/mascots_collection.dart';
import 'package:mascot/features/mascot/data/models/expression_model.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

class IsarMascotsCollectionImpl extends IsarMascotsCollection {}

class HiveMascotsCollectionImpl extends HiveMascotsCollection {}

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

void main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('IsarMascotsCollection', () {
    late IsarMascotsCollection isarMascotsCollection;
    late IsarCollection<MascotModel> isarCollection;
    setUp(() {
      isarMascotsCollection = IsarMascotsCollectionImpl();
      isarCollection = MockIsarCollection<MascotModel>();
    });

    test('should return isar collection', () {
      // arrange
      when(context.mocks.isar.collection<MascotModel>())
          .thenReturn(isarCollection);

      // act
      final collection = isarMascotsCollection.create(context.mocks.isar);

      // assert
      expect(collection, isarCollection);
    });
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
      verify(context.mocks.hiveInterface.registerAdapter(MascotModelAdapter()));
    });

    test('should register ExpressionModel adapter for hive', () async {
      // act
      await hiveMascotsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(
        context.mocks.hiveInterface.registerAdapter(ExpressionModelAdapter()),
      );
    });
  });
}
