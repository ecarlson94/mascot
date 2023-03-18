import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/constants.dart';
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

    setUp(() {
      context = TestContext();
      bloc = MascotAnimatorBloc(context.mocks.streamMascot);
      mascotSubject = BehaviorSubject<Mascot>.seeded(context.data.mascot);

      when(context.mocks.streamMascot(any))
          .thenAnswer((_) async => Right(mascotSubject));
    });

    test('initial state is MascotInitial', () {
      // assert
      expect(bloc.state, MascotAnimatorInitial(none(), defaultExpressionName));
    });

    group('LoadMascotStream', () {
      blocTest(
        'should emit [MascotLoaded] when retrieval of mascot is successful',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadMascot(context.data.mascot.id)),
        expect: () => [
          MascotAnimatorLoading(none(), defaultExpressionName),
          isA<MascotLoaded>(),
        ],
      );

      blocTest(
        'should use mascot to create expression map',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadMascot(context.data.mascot.id)),
        verify: (bloc) async {
          var expressionMapOption = bloc.state.expressionMapOption;
          expect(expressionMapOption, isSome);
          var map = expressionMapOption.getOrFailTest();
          expect(
            map,
            {for (var e in context.data.mascot.expressions) e.name: e},
          );
        },
      );

      blocTest(
        'updated mascot emits new MascotAnimatorLoaded event',
        build: () => bloc,
        act: (bloc) async {
          bloc.add(LoadMascot(context.data.mascot.id));
          await Future.delayed(const Duration(milliseconds: 100));
          mascotSubject.add(
            context.data.mascot.copyWith(
              expressions: context.data.expressions.skip(1).toSet(),
            ),
          );
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MascotAnimatorLoading(none(), defaultExpressionName),
          isA<MascotLoaded>(),
          isA<MascotLoaded>(),
        ],
        verify: (bloc) async {
          var expressionMapOption = bloc.state.expressionMapOption;
          expect(expressionMapOption, isSome);
          var map = expressionMapOption.getOrFailTest();
          expect(
            map,
            {for (var e in context.data.mascot.expressions.skip(1)) e.name: e},
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
          MascotAnimatorLoading(none(), defaultExpressionName),
          MascotAnimatorError(
            ErrorCodes.loadMascotFailureCode,
            none(),
            defaultExpressionName,
          ),
        ],
      );
    });
  });
}
