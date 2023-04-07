import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionsRepositoryImpl repository;

  setUp(() {
    context = TestContext();
    repository = ExpressionsRepositoryImpl(
      context.mocks.expressionsLocalDataSource,
      context.data.expressionMapper,
      context.mocks.getLogger(),
    );

    when(context.mocks.expressionsLocalDataSource.putObject(any))
        .thenAnswer((_) async => _.positionalArguments.first.id);
  });

  group('ExpressionsRepositoryImpl', () {
    group('saveExpressions', () {
      test(
        'should save expressions to data source',
        () async {
          // Arrange
          final expressions = context.data.expressions;

          // Act
          await repository.saveExpressions(expressions);

          // Assert
          for (var expression in expressions) {
            verify(context.mocks.expressionsLocalDataSource.putObject(
              context.data.expressionMapper.fromExpression(expression),
            )).called(1);
          }
        },
      );

      test(
        'should return newly created expression ids when save is successful',
        () async {
          // Arrange
          final expressions = context.data.expressions;
          final expectedIds = expressions.map((e) => e.id).toList();

          // Act
          final result = await repository.saveExpressions(expressions);

          // Assert
          var actualIds = result.getOrFailTest();
          expect(actualIds, expectedIds);
        },
      );

      test(
        'should return LocalDataSourceFailure when exception occurs',
        () async {
          // Arrange
          final expressions = context.data.expressions;
          when(context.mocks.expressionsLocalDataSource.putObject(any))
              .thenThrow(Exception());

          // Act
          final result = await repository.saveExpressions(expressions);

          // Assert
          expect(result, isA<Left>());
          expect(
            result.swap().getOrFailTest(),
            isA<LocalDataSourceFailure>(),
          );
        },
      );
    });

    group('getExpressions', () {
      test(
        'should return expressions from data source',
        () async {
          // Arrange
          final ids = context.data.expressions.map((e) => e.id).toList();
          final expectedExpressions = context.data.expressions;
          when(context.mocks.expressionsLocalDataSource.getObjects(any))
              .thenAnswer((_) async => expectedExpressions
                  .map(context.data.expressionMapper.fromExpression)
                  .toList());

          // Act
          final result = await repository.getExpressions(ids);

          // Assert
          expect(result.getOrFailTest(), expectedExpressions);
        },
      );

      test(
        'should return LocalDataSourceFailure when exception occurs',
        () async {
          // Arrange
          final ids = context.data.expressions.map((e) => e.id).toList();
          when(context.mocks.expressionsLocalDataSource.getObjects(any))
              .thenThrow(Exception());

          // Act
          final result = await repository.getExpressions(ids);

          // Assert
          expect(result, isA<Left>());
          expect(
            result.swap().getOrFailTest(),
            isA<LocalDataSourceFailure>(),
          );
        },
      );
    });
  });
}
