import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_actions.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart';

import '../../../../../fixtures/option.dart';
import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;

  setUp(() {
    context = TestContext();
  });

  group('CreateMascotBloc', () {
    group('formGroup', () {
      test(
        'should not be valid if natural expression is empty but other fields are not',
        () async {
          // arrange
          final form = getInitialForm();
          form
              .control(CreateMascotBloc.talkingExpressionFormControlName)
              .value = context.data.imageFile;
          form.control(CreateMascotBloc.nameFormControlName).value =
              'valid_name';

          // assert
          expect(form.valid, false);
        },
      );

      test(
        'should not be valid if talk expression is empty but other fields are not',
        () async {
          // arrange
          var form = getInitialForm();
          form
              .control(CreateMascotBloc.neutralExpressionFormControlName)
              .value = context.data.imageFile;
          form.control(CreateMascotBloc.nameFormControlName).value =
              'valid_name';

          // assert
          expect(form.valid, false);
        },
      );

      test(
        'should not be valid if mascot name is empty but other fields are not',
        () async {
          // arrange
          var form = getInitialForm();
          form
              .control(CreateMascotBloc.neutralExpressionFormControlName)
              .value = context.data.imageFile;
          form
              .control(CreateMascotBloc.talkingExpressionFormControlName)
              .value = context.data.imageFile;

          // assert
          expect(form.valid, false);
        },
      );
    });

    group('initialize', () {
      test('should return state with initial form', () {
        final event = InitializeEvent();
        final state = CreateMascotState(none(), none(), none(), false);

        var result = initialize(event, state);

        expect(result, equals(initialCreateMascotState));
      });
    });

    group('savingMascot', () {
      test('should return state the current state\'s form', () {
        // arrange
        var event = SavingMascotEvent();
        var state = initialCreateMascotState;

        // act
        var result = savingMascot(event, state);

        // assert
        expect(
          result,
          equals(
            CreateMascotState(
              state.form,
              state.mascot,
              state.failureCode,
              true,
            ),
          ),
        );
      });

      test('should set isSaving to true', () {
        // arrange
        var event = SavingMascotEvent();
        var state = CreateMascotState(none(), none(), none(), false);

        // act
        var result = savingMascot(event, state);

        // assert
        expect(result.isSaving, isTrue);
      });

      test('should mark form as disabled', () {
        // arrange
        var event = SavingMascotEvent();
        var state = initialCreateMascotState;

        // act
        var result = savingMascot(event, state);
        var newForm = result.form.getOrFailTest();

        // assert
        expect(newForm.disabled, isTrue);
      });
    });

    group('saveMascotFailed', () {
      test(
        'should return state with event failure code and the current state\'s form',
        () {
          // arrange
          var errorCode = 100;
          var event = SaveMascotFailure(errorCode);
          var state = initialCreateMascotState;

          // act
          var result = saveMascotFailed(event, state);

          // assert
          expect(
            result,
            equals(CreateMascotState(
                state.form, state.mascot, some(errorCode), false)),
          );
        },
      );

      test('should set isSaving to false', () {
        // arrange
        var errorCode = 100;
        var event = SaveMascotFailure(errorCode);
        var state = CreateMascotState(none(), none(), none(), true);

        // act
        var result = saveMascotFailed(event, state);

        // assert
        expect(result.isSaving, false);
      });

      test(
        'should mark form as enabled',
        () {
          // arrange
          var errorCode = 100;
          var event = SaveMascotFailure(errorCode);
          var state = initialCreateMascotState;
          var form = state.form.getOrFailTest();
          form.markAsDisabled();

          // act
          var result = saveMascotFailed(event, state);
          var newForm = result.form.getOrFailTest();

          // assert
          expect(newForm.disabled, isFalse);
        },
      );
    });

    group('saveMascotSuccess', () {
      test(
        'should return state with event mascot and the current state\'s form',
        () {
          // arrange
          var event = SaveMascotSuccess(context.data.mascot);
          var state = CreateMascotState(none(), none(), none(), true);

          // act
          var result = saveMascotSuccess(event, state);

          // assert
          expect(
            result,
            equals(CreateMascotState(
              state.form,
              some(event.mascot),
              state.failureCode,
              false,
            )),
          );
        },
      );

      test('should set isSaving to false', () {
        // arrange
        var event = SaveMascotSuccess(context.data.mascot);
        var state = CreateMascotState(none(), none(), none(), true);

        // act
        var result = saveMascotSuccess(event, state);

        // assert
        expect(result.isSaving, false);
      });

      test(
        'should mark form as enabled',
        () {
          // arrange
          var event = SaveMascotSuccess(context.data.mascot);
          var state = initialCreateMascotState;
          var form = state.form.getOrFailTest();
          form.markAsDisabled();

          // act
          var result = saveMascotSuccess(event, state);
          var newForm = result.form.getOrFailTest();

          // assert
          expect(newForm.disabled, isFalse);
        },
      );
    });
  });
}
