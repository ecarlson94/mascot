import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotUpdatedEffect effect;
  late Stream<Expression> expressionStream;

  setUp(() {
    context = TestContext();
    effect = MascotUpdatedEffect(context.mocks.expressionAnimationService);
    expressionStream = Stream.fromIterable([
      context.data.mascot.expressions.first,
      context.data.mascot.expressions.last,
    ]);

    when(context.mocks.expressionAnimationService.animateExpressions(any))
        .thenAnswer(
      (_) async => expressionStream,
    );
  });

  group('MascotAnimatorBloc MascotUpdatedEffect', () {
    test(
      'should invoke ExpressionAnimationService.animateExpressions with mascot expressions',
      () async {
        // arrange
        final event = MascotUpdated(context.data.mascot);
        final state = MascotAnimatorInitial();

        // act
        await effect(event, state).toList();

        // assert
        verify(
          context.mocks.expressionAnimationService.animateExpressions(
            context.data.mascot.expressions,
          ),
        );
      },
    );

    test(
      'should map expression animation stream to SetExpression events',
      () async {
        // arrange
        final event = MascotUpdated(context.data.mascot);
        final state = MascotAnimatorInitial();

        // act
        final result = effect(event, state);
        var events = await result.take(2).toList();

        // assert
        expect(
          events,
          [
            SetExpression(context.data.mascot.expressions.first),
            SetExpression(context.data.mascot.expressions.last),
          ],
        );
      },
    );
  });
}
