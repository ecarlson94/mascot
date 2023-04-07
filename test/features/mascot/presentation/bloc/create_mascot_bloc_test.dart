import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  group('CreateMascotBloc', () {
    const blocWaitDuration = Duration(milliseconds: 25);

    late TestContext context;
    late CreateMascotBloc bloc;

    setUp(() {
      context = TestContext();
      bloc = CreateMascotBloc(
        context.mocks.addMascot,
      );

      when(context.mocks.addMascot(any))
          .thenAnswer((_) async => Right(context.data.mascot));
    });

    test('initialState should be CreateMascotInitial', () {
      // assert
      expect(bloc.state, CreateMascotInitial(none()));
    });

    group('Initialize', () {
      blocTest<CreateMascotBloc, CreateMascotState>(
        'should emit [CreateMascotInitial] state with empty form',
        build: () => bloc,
        act: (bloc) => bloc.add(Initialize()),
        expect: () => [
          isA<CreateMascotInitial>()
              .having((state) => state.form.isSome(), 'isSome', true)
              .having(
                (state) => state.form
                    .getOrFailTest()
                    .control(CreateMascotBloc.talkingExpressionFormControlName)
                    .pristine,
                'talkingExpressionPristine',
                true,
              )
              .having(
                (state) => state.form
                    .getOrFailTest()
                    .control(CreateMascotBloc.neutralExpressionFormControlName)
                    .pristine,
                'neutralExpressionPristine',
                true,
              )
              .having(
                (state) => state.form
                    .getOrFailTest()
                    .control(CreateMascotBloc.nameFormControlName)
                    .pristine,
                'mascotNamePristine',
                true,
              ),
        ],
      );

      group('formGroup', () {
        test(
          'should not be valid if natural expression is empty but other fields are not',
          () async {
            // arrange
            bloc.add(Initialize());
            await Future.delayed(blocWaitDuration);

            var form = bloc.state.form.getOrFailTest();
            form
                .control(CreateMascotBloc.talkingExpressionFormControlName)
                .value = context.data.imageFile;
            form.control(CreateMascotBloc.nameFormControlName).value =
                'valid_name';

            expect(form.valid, false);
          },
        );

        test(
          'should not be valid if talk expression is empty but other fields are not',
          () async {
            // arrange
            bloc.add(Initialize());
            await Future.delayed(blocWaitDuration);

            var form = bloc.state.form.getOrFailTest();
            form
                .control(CreateMascotBloc.neutralExpressionFormControlName)
                .value = context.data.imageFile;
            form.control(CreateMascotBloc.nameFormControlName).value =
                'valid_name';

            expect(form.valid, false);
          },
        );

        test(
          'should not be valid if mascot name is empty but other fields are not',
          () async {
            // arrange
            bloc.add(Initialize());
            await Future.delayed(blocWaitDuration);

            var form = bloc.state.form.getOrFailTest();
            form
                .control(CreateMascotBloc.neutralExpressionFormControlName)
                .value = context.data.imageFile;
            form
                .control(CreateMascotBloc.talkingExpressionFormControlName)
                .value = context.data.imageFile;

            expect(form.valid, false);
          },
        );
      });
    });

    group('SaveMascot', () {
      Future<void> fillAndSaveForm(CreateMascotBloc bloc) async {
        bloc.add(Initialize());
        await Future.delayed(blocWaitDuration);

        var form = bloc.state.form.getOrFailTest();
        form.control(CreateMascotBloc.neutralExpressionFormControlName).value =
            context.data.imageFile;
        form.control(CreateMascotBloc.talkingExpressionFormControlName).value =
            context.data.imageFile;
        form.control(CreateMascotBloc.nameFormControlName).value = 'valid_name';
        form.markAllAsTouched();

        bloc.add(SaveMascot());
        await Future.delayed(blocWaitDuration);
      }

      blocTest<CreateMascotBloc, CreateMascotState>(
        'should invoke SaveMascot usecase when form is valid',
        build: () => bloc,
        act: (bloc) async {
          await fillAndSaveForm(bloc);
        },
        verify: (bloc) {
          verify(context.mocks.addMascot(any)).called(1);
        },
      );

      blocTest<CreateMascotBloc, CreateMascotState>(
        'should emit [MascotSaved] state when the usecase succeeds',
        build: () => bloc,
        act: (bloc) async {
          await fillAndSaveForm(bloc);
        },
        expect: () => [
          isA<CreateMascotInitial>(),
          isA<SavingMascot>(),
          isA<MascotSaved>(),
        ],
      );

      blocTest<CreateMascotBloc, CreateMascotState>(
        'should emit [SaveMascotError(${ErrorCodes.invalidInputFailureCode})] when the form is invalid',
        build: () => bloc,
        act: (bloc) async {
          bloc.add(Initialize());
          await Future.delayed(blocWaitDuration);

          bloc.add(SaveMascot());
          await Future.delayed(blocWaitDuration);
        },
        expect: () => [
          isA<CreateMascotInitial>(),
          SaveMascotError(ErrorCodes.invalidInputFailureCode, bloc.state.form),
        ],
      );

      blocTest<CreateMascotBloc, CreateMascotState>(
        'should emit [SaveMascotError(${ErrorCodes.saveMascotFailureCode})] when the usecase fails',
        build: () {
          when(context.mocks.addMascot(any))
              .thenAnswer((_) async => Left(InvalidInputFailure()));
          return bloc;
        },
        act: (bloc) async {
          await fillAndSaveForm(bloc);
        },
        expect: () => [
          isA<CreateMascotInitial>(),
          isA<SavingMascot>(),
          SaveMascotError(ErrorCodes.saveMascotFailureCode, bloc.state.form),
        ],
      );
    });
  });
}
