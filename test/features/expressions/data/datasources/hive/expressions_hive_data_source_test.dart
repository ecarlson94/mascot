import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/datasources/hive/expressions_hive_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionsHiveDataSource dataSource;

  setUp(() {
    context = TestContext();
    dataSource = ExpressionsHiveDataSourceImpl(
      context.mocks.expressionsCollectionAdapter,
      context.data.mapExpressionToHiveExpression,
    );
  });

  group('ExpressionsHiveDataSourceImpl', () {
    group('getExpression', () {
      test('should return ExpressionModel from local database', () async {
        // arrange
        when(context.mocks.expressionsCollectionAdapter.get(any))
            .thenAnswer((_) async => context.data.hiveExpression);

        // act
        final result = await dataSource.getExpression(1);

        // assert
        expect(result, context.data.hiveExpression);
        verify(context.mocks.expressionsCollectionAdapter.get(1));
        verifyNoMoreInteractions(context.mocks.expressionsCollectionAdapter);
      });
    });

    group('addExpression', () {
      test(
        'should return new expression id from local database after adding image to database',
        () async {
          // arrange
          var id = 1;
          when(context.mocks.expressionsCollectionAdapter.add(any))
              .thenAnswer((_) async => id);

          // act
          final result =
              await dataSource.addExpression(context.data.hiveExpression);

          // assert
          expect(result, equals(id));
          verify(context.mocks.expressionsCollectionAdapter
              .add(context.data.hiveExpression));
          verifyNoMoreInteractions(context.mocks.expressionsCollectionAdapter);
        },
      );
    });

    group('removeExpression', () {
      test(
        'should remove expression from local database',
        () async {
          // arrange
          when(context.mocks.expressionsCollectionAdapter.remove(any))
              .thenAnswer((_) async => true);

          // act
          await dataSource.removeExpression(1);

          // assert
          verify(context.mocks.expressionsCollectionAdapter.remove(1));
          verifyNoMoreInteractions(context.mocks.expressionsCollectionAdapter);
        },
      );
    });

    group('getExpressions', () {
      test(
        'should return list of ExpressionModels from local database',
        () async {
          // arrange
          var ids = context.data.hiveExpressions.map((e) => e.id).toList();
          when(context.mocks.expressionsCollectionAdapter.getMany(any))
              .thenAnswer((_) async => context.data.hiveExpressions);

          // act
          final result = await dataSource.getExpressions(ids);

          // assert
          expect(result, context.data.hiveExpressions);
          verify(context.mocks.expressionsCollectionAdapter.getMany(ids));
          verifyNoMoreInteractions(context.mocks.expressionsCollectionAdapter);
        },
      );
    });
  });
}
