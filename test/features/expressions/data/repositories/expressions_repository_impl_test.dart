import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionsRepositoryImpl repository;

  setUp(() {
    context = TestContext();
    repository = ExpressionsRepositoryImpl(
      context.mocks.expressionsHiveDataSource,
      context.data.mapExpressionToHiveExpression,
    );
  });

  group('ExpressionsRepositoryImpl', () {
    group('getExpression', () {
      test(
        'should return the requested expression when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.getExpression(any))
              .thenAnswer((_) => Future.value(context.data.hiveExpression));

          // act
          final result =
              await repository.getExpression(context.data.expression.id);

          // assert
          expect(result, Right(context.data.expression));

          verify(context.mocks.expressionsHiveDataSource
              .getExpression(context.data.expression.id));
          verifyNoMoreInteractions(context.mocks.expressionsHiveDataSource);
        },
      );

      test(
        'should convert ExpressionModel to Expression',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.getExpression(any))
              .thenAnswer((_) => Future.value(context.data.hiveExpression));

          // act
          final result =
              await repository.getExpression(context.data.expression.id);

          // assert
          expect(
            result.getOrElse(() => Expression.empty),
            isNot(isA<ExpressionModel>()),
          );
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.getExpression(any))
              .thenThrow(Exception());

          // act
          final result =
              await repository.getExpression(context.data.expression.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );
    });

    group('addExpression', () {
      test(
        'should return new expression id when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.addExpression(any))
              .thenAnswer((_) async => context.data.hiveExpression.id);

          // act
          final result =
              await repository.addExpression(context.data.expression);

          // assert
          expect(result, Right(context.data.hiveExpression.id));
          verify(context.mocks.expressionsHiveDataSource
              .addExpression(context.data.hiveExpression));
          verifyNoMoreInteractions(context.mocks.expressionsHiveDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.addExpression(any))
              .thenThrow(Exception());

          // act
          final result =
              await repository.addExpression(context.data.expression);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );
    });

    group('addExpressions', () {
      test(
        'should return new expression ids when call to local data source is successful',
        () async {
          // arrange
          var ids = context.data.expressions.map((e) => e.id).toList();
          when(context.mocks.expressionsHiveDataSource.addExpression(any))
              .thenAnswer(
            (_) async => (_.positionalArguments[0] as ExpressionModel).id,
          );

          // act
          final result =
              await repository.addExpressions(context.data.expressions);

          // assert
          expect(result, isA<Right<Failure, List<Id>>>());
          expect(ids, equals(result.getOrElse(() => <Id>[])));
          for (var expressionModel in context.data.hiveExpressions) {
            verify(context.mocks.expressionsHiveDataSource
                .addExpression(expressionModel));
          }
          verifyNoMoreInteractions(context.mocks.expressionsHiveDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.expressionsHiveDataSource.addExpression(any))
              .thenThrow(Exception());

          // act
          final result =
              await repository.addExpressions(context.data.expressions);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );

      test(
        'should remove successful expressions when call to local data source is unsuccessful',
        () async {
          // arrange
          var expressionModel1 = context.data.hiveExpressions.first;
          var expressionModel2 = context.data.hiveExpressions.skip(1).first;
          when(context.mocks.expressionsHiveDataSource
                  .addExpression(expressionModel1))
              .thenAnswer(
            (_) async => (_.positionalArguments[0] as ExpressionModel).id,
          );
          when(context.mocks.expressionsHiveDataSource
                  .addExpression(expressionModel2))
              .thenThrow(Exception());
          when(context.mocks.expressionsHiveDataSource.removeExpression(any))
              .thenAnswer((_) async {});

          // act
          await repository.addExpressions(context.data.expressions);

          // assert
          verify(
            context.mocks.expressionsHiveDataSource
                .removeExpression(expressionModel1.id),
          );
        },
      );
    });

    group('getExpressions', () {
      test(
        'should return all expressions when call to local data source is successful',
        () async {
          // arrange
          var ids = context.data.expressions.map((e) => e.id).toList();
          when(context.mocks.expressionsHiveDataSource.getExpressions(any))
              .thenAnswer((_) => Future.value(context.data.hiveExpressions));

          // act
          final result = await repository.getExpressions(ids);

          // assert
          expect(result, isA<Right<Failure, List<Expression>>>());
          expect(
            result.getOrElse(() => []),
            context.data.expressions,
          );
          verify(context.mocks.expressionsHiveDataSource.getExpressions(ids));
          verifyNoMoreInteractions(context.mocks.expressionsHiveDataSource);
        },
      );

      test('should convert ExpressionModels to Expressions', () async {
        // arrange
        var ids = context.data.expressions.map((e) => e.id).toList();
        when(context.mocks.expressionsHiveDataSource.getExpressions(any))
            .thenAnswer((_) => Future.value(context.data.hiveExpressions));

        // act
        final result = await repository.getExpressions(ids);

        // assert
        expect(
          result.getOrElse(() => <Expression>[]),
          isNot(isA<List<ExpressionModel>>()),
        );
      });

      test(
          'should return failure when call to local data source is unsuccessful',
          () async {
        // arrange
        when(context.mocks.expressionsHiveDataSource.getExpressions(any))
            .thenThrow(Exception());

        // act
        final result = await repository.getExpressions([]);

        // assert
        expect(result, Left(LocalDataSourceFailure()));
      });
    });
  });
}
