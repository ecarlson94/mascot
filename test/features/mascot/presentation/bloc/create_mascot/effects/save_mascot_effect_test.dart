import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_actions.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../fixtures/test_context.dart';
import 'package:reactive_forms/src/models/models.dart';

void main() {
  late TestContext context;
  late SaveMascotEffect effect;
  late Mascot mascotToSave;
  late Mascot savedMascot;

  setUp(() {
    context = TestContext();
    effect = SaveMascotEffect(context.mocks.addMascot);
    mascotToSave = Mascot(
      id: 0,
      name: 'valid_name',
      expressions: {
        Expression(
          id: 0,
          name: SaveMascotEffect.neutralExpressionName,
          description: SaveMascotEffect.neutralExpressionDescription,
          image: context.data.imageFile.bytes,
          priority: SaveMascotEffect.neutralExpressionPriority,
          activator: ExpressionTriggers.always,
        ),
        Expression(
          id: 0,
          name: SaveMascotEffect.talkingExpressionName,
          description: SaveMascotEffect.talkingExpressionDescription,
          image: context.data.imageFile.bytes,
          priority: SaveMascotEffect.talkingExpressionPriority,
          activator: ExpressionTriggers.talking,
        ),
      },
    );
    savedMascot = context.data.mascot;

    when(context.mocks.addMascot(any))
        .thenAnswer((_) async => Right(savedMascot));
  });

  void fillForm(FormGroup form) {
    form.control(CreateMascotBloc.neutralExpressionFormControlName).value =
        context.data.imageFile;
    form.control(CreateMascotBloc.talkingExpressionFormControlName).value =
        context.data.imageFile;
    form.control(CreateMascotBloc.nameFormControlName).value = 'valid_name';
    form.markAllAsTouched();
  }

  FormGroup createAndFillForm() {
    var form = getInitialForm();
    fillForm(form);
    return form;
  }

  group('CreateMascotBloc SaveMascotEffect', () {
    test(
      'should return [SaveMascotFailure] events when form is invalid',
      () async {
        // arrange
        var state = initialCreateMascotState;

        // act
        var result = effect(SaveMascot(), state);
        var events = await result.toList();

        // assert
        expect(
          events,
          equals([const SaveMascotFailure(ErrorCodes.invalidInputFailureCode)]),
        );
      },
    );

    test(
      'should return [SavingMascotEvent, SaveMascotSuccess] events when usecase is successful',
      () async {
        // arrange
        var form = createAndFillForm();
        var state = CreateMascotState(some(form), none(), none(), false);

        // act
        var result = effect(SaveMascot(), state);
        var events = await result.toList();

        // assert
        expect(events,
            equals([SavingMascotEvent(), SaveMascotSuccess(savedMascot)]));
      },
    );

    test(
      'should invoke SaveMascot usecase when form is valid',
      () async {
        // arrange
        var form = createAndFillForm();
        var state = CreateMascotState(some(form), none(), none(), false);

        // act
        var result = effect(SaveMascot(), state);
        await result.toList();

        // assert
        verify(context.mocks.addMascot(mascotToSave));
      },
    );

    test(
      'should return [SavingMascotEvent, SaveMascotFailure] events when usecase fails',
      () async {
        // arrange
        var form = createAndFillForm();
        var state = CreateMascotState(some(form), none(), none(), false);
        when(context.mocks.addMascot(any))
            .thenAnswer((_) async => Left(LocalDataSourceFailure()));

        // act
        var result = effect(SaveMascot(), state);
        var events = await result.toList();

        // assert
        expect(
          events,
          equals([
            SavingMascotEvent(),
            const SaveMascotFailure(ErrorCodes.saveMascotFailureCode)
          ]),
        );
      },
    );
  });
}
