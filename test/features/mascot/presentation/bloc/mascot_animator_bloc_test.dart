import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  group('MascotAnimatorBloc', () {
    late TestContext context;
    late MascotAnimatorBloc bloc;
    late BehaviorSubject<Mascot> mascotSubject;
    late BehaviorSubject<Expression> animationStream;

    setUp(() {
      context = TestContext();
      bloc = MascotAnimatorBloc(
        context.mocks.streamMascot,
        context.mocks.expressionAnimationService,
      );
      mascotSubject = BehaviorSubject<Mascot>.seeded(context.data.mascot);
      animationStream = BehaviorSubject<Expression>.seeded(
        context.data.expressions.first,
      );

      when(context.mocks.streamMascot(any))
          .thenAnswer((_) async => Right(mascotSubject));
      when(context.mocks.expressionAnimationService.animateExpressions(any))
          .thenAnswer((_) async => animationStream);
    });

    test('initial state is MascotInitial', () {
      // assert
      expect(bloc.state, MascotAnimatorInitial(none()));
    });

    group('LoadMascotStream', () {
      blocTest(
        'should emit [ExpressionChanged] when retrieval of mascot is successful',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadMascot(context.data.mascot.id)),
        expect: () => [
          MascotAnimatorLoading(none()),
          isA<ExpressionChanged>(),
        ],
      );

      blocTest(
        'updated mascot emits new MascotAnimatorLoaded event',
        build: () => bloc,
        act: (bloc) async {
          bloc.add(LoadMascot(context.data.mascot.id));
          await Future.delayed(const Duration(milliseconds: 25));
          mascotSubject.add(
            context.data.mascot.copyWith(
              expressions: context.data.expressions.skip(1).toSet(),
            ),
          );
        },
        wait: const Duration(milliseconds: 25),
        expect: () => [
          MascotAnimatorLoading(none()),
          isA<ExpressionChanged>(),
        ],
        verify: (bloc) async {
          var expressionOption = bloc.state.expressionOption;
          expect(expressionOption, isSome);
          var expression = expressionOption.getOrFailTest();
          expect(
            expression,
            context.data.expressions
                .firstWhere((e) => e.name == expression.name),
          );
        },
      );

      blocTest(
        'should emit [MascotAnimatorLoading, MascotAnimatorError(${ErrorCodes.loadMascotFailureCode})] when retrieval of mascot stream is unsuccessful',
        build: () => bloc,
        setUp: () {
          when(context.mocks.streamMascot(any))
              .thenAnswer((_) async => Left(LocalDataSourceFailure()));
        },
        act: (bloc) => bloc.add(LoadMascot(context.data.mascot.id)),
        expect: () => [
          MascotAnimatorLoading(none()),
          MascotAnimatorError(
            ErrorCodes.loadMascotFailureCode,
            none(),
          ),
        ],
      );
    });

    group('SetExpression', () {
      blocTest(
        'should emit [ExpressionChanged] when SetExpression event is received',
        build: () => bloc,
        act: (bloc) => bloc.add(SetExpression(context.data.expressions.first)),
        expect: () => [
          ExpressionChanged(some(context.data.expressions.first)),
        ],
      );
    });

    group('SetMascot', () {
      blocTest(
        'should emit [ExpressionChanged] when new animation is triggered',
        build: () => bloc,
        act: (bloc) async => {
          bloc.add(SetMascot(context.data.mascot)),
          await Future.delayed(const Duration(milliseconds: 25)),
          animationStream.add(context.data.expressions.last),
          await Future.delayed(const Duration(milliseconds: 25)),
        },
        expect: () => [
          ExpressionChanged(some(context.data.expressions.first)),
          ExpressionChanged(some(context.data.expressions.last)),
        ],
      );
    });
  });
}
