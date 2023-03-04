import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/usecases/get_expression.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late GetExpression usecase;

  setUp(() {
    context = TestContext();
    usecase = GetExpression(context.mocks.expressionsRepository);
  });

  test(
    'GetExpression usecase should get the requested image from the repository',
    () async {
      // arrange
      when(context.mocks.expressionsRepository.getExpression(any))
          .thenAnswer((_) async => Right(context.data.expression));

      // act
      final result = await usecase(context.data.expression.id);

      // assert
      expect(result, Right(context.data.expression));
      verify(
        context.mocks.expressionsRepository
            .getExpression(context.data.expression.id),
      );
      verifyNoMoreInteractions(context.mocks.expressionsRepository);
    },
  );
}
