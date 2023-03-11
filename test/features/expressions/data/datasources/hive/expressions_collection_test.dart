import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mascot/core/data/hive/hive_collection_adapter.dart';
import 'package:mascot/features/expressions/data/datasources/hive/expressions_collection.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/hive_expression.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/hive_image.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

class HiveExpressionsCollectionImpl extends ExpressionsCollection {}

class ExpressionsCollectionAdapterImpl extends ExpressionsCollectionAdapter {}

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

void main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('HiveExpressionsCollection', () {
    late HiveExpressionsCollectionImpl hiveExpressionsCollection;
    setUp(() {
      hiveExpressionsCollection = HiveExpressionsCollectionImpl();
      when(context.mocks.hiveInterface.openBox<ExpressionModel>(any))
          .thenAnswer((_) async => context.mocks.hiveImageBox);
    });

    test('should open ExpressionModel box for hive', () async {
      // act
      final box =
          await hiveExpressionsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(
        context.mocks.hiveInterface.openBox<ExpressionModel>('expressions'),
      );
      expect(box, context.mocks.hiveImageBox);
    });

    test('should register ImageModel adapter for hive', () async {
      // act
      await hiveExpressionsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(context.mocks.hiveInterface.registerAdapter(HiveImageAdapter()));
    });

    test('should register ExpressionModel adapter for hive', () async {
      // act
      await hiveExpressionsCollection.create(context.mocks.hiveInterface);

      // assert
      verify(
        context.mocks.hiveInterface.registerAdapter(HiveExpressionAdapter()),
      );
    });
  });

  group('ExpressionsCollectionAdapter', () {
    late ExpressionsCollectionAdapter expressionsCollectionAdapter;
    setUp(() {
      expressionsCollectionAdapter = ExpressionsCollectionAdapterImpl();
    });

    test('should return HiveCollectionAdapter', () {
      // act
      final adapter = expressionsCollectionAdapter.create(
        context.mocks.hiveImageBox,
      );

      // assert
      expect(adapter, isA<HiveCollectionAdapter<HiveExpression>>());
    });
  });
}
