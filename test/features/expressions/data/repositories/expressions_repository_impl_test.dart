import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

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
        .thenAnswer((_) => Single.value(_.positionalArguments.first.id));
  });

  group('ExpressionsRepositoryImpl', () {
    group('saveExpressions', () {
      test(
        'should save expressions to data source',
        () async {
          // Arrange
          final expressions = context.data.expressions;

          // Act
          await repository.saveExpressions(expressions).single;

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
          final result = await repository.saveExpressions(expressions).single;

          // Assert
          expect(result, expectedIds);
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
              .thenAnswer(
            (_) => Single.value(expectedExpressions
                .map(context.data.expressionMapper.fromExpression)
                .toList()),
          );

          // Act
          final result = await repository.getExpressions(ids).single;

          // Assert
          expect(result, expectedExpressions);
        },
      );
    });
  });
}
