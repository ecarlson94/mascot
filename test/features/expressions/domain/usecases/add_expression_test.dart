import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/usecases/add_expression.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late AddExpression usecase;

  setUp(() {
    context = TestContext();
    usecase = AddExpression(context.mocks.expressionsRepository);
  });

  test(
    'AddExpression usecase should save the provided image to the repository',
    () async {
      // arrange
      when(context.mocks.expressionsRepository.addExpression(any))
          .thenAnswer((_) async => Right(context.data.expression.id));

      // act
      final result = await usecase(context.data.expression);

      // assert
      expect(result, Right(context.data.expression.id));
      verify(
        context.mocks.expressionsRepository
            .addExpression(context.data.expression),
      );
      verifyNoMoreInteractions(context.mocks.expressionsRepository);
    },
  );
}
