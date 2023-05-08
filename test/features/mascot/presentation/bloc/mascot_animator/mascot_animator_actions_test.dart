import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/mascot_animator_actions.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;

  setUp(() {
    context = TestContext();
  });

  group('MascotAnimatorBloc', () {
    group('setExpression', () {
      test('should return ExpressionChanged', () {
        // assemble
        var state = MascotAnimatorInitial();

        // act
        var result = setExpression(
          SetExpressionEvent(context.data.expression),
          state,
        );

        // assert
        expect(result, ExpressionChanged(some(context.data.expression)));
      });
    });

    group('loadingMascot', () {
      test('should return MascotAnimatorLoading', () {
        // assemble
        var state = MascotAnimatorInitial();

        // act
        var result = loadingMascot(
          const LoadingMascotEvent(),
          state,
        );

        // assert
        expect(result, MascotAnimatorLoading(none()));
      });

      test('should use the expression of the current state', () {
        // assemble
        var state = ExpressionChanged(some(context.data.expression));

        // act
        var result = loadingMascot(
          const LoadingMascotEvent(),
          state,
        );

        // assert
        expect(result, MascotAnimatorLoading(some(context.data.expression)));
      });
    });

    group('streamMascotError', () {
      test('should return MascotAnimatorError', () {
        // assemble
        var state = MascotAnimatorInitial();

        // act
        var result = streamMascotError(
          const StreamMascotErrorEvent(),
          state,
        );

        // assert
        expect(
          result,
          MascotAnimatorError(ErrorCodes.loadMascotFailureCode, none()),
        );
      });

      test('should use the expression of the current state', () {
        // assemble
        var state = ExpressionChanged(some(context.data.expression));

        // act
        var result = streamMascotError(
          const StreamMascotErrorEvent(),
          state,
        );

        // assert
        expect(
          result,
          MascotAnimatorError(
            ErrorCodes.loadMascotFailureCode,
            some(context.data.expression),
          ),
        );
      });
    });
  });
}
