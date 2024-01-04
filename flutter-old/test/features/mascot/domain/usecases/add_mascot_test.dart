import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late AddMascot usecase;
  late Mascot newMascot;
  late Mascot updatedMascot;

  setUp(() {
    context = TestContext();
    usecase = AddMascot(
      context.mocks.mascotsRepository,
      context.mocks.expressionsRepository,
      context.mocks.settingsRepository,
      context.mocks.getLogger(),
    );
    updatedMascot = context.data.mascot.copyWith(
      name: 'Updated name',
    );
    newMascot = context.data.mascot.copyWith(
      id: 0,
    );

    when(context.mocks.mascotsRepository.saveMascot(any))
        .thenAnswer((_) => Single.value(context.data.mascot.id));
    when(context.mocks.settingsRepository.loadSettings())
        .thenAnswer((_) => Single.value(Settings.empty));
    when(context.mocks.settingsRepository.setFavoriteMascotId(any))
        .thenAnswer((_) => Single.value(unit));
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) => Single.value(updatedMascot));
    when(context.mocks.expressionsRepository.saveExpressions(any)).thenAnswer(
      (_) => Single.value(newMascot.expressions.map((e) => e.id).toList()),
    );
    when(context.mocks.expressionsRepository.getExpressions(any))
        .thenAnswer((_) => Single.value(newMascot.expressions.toList()));
  });

  group('AddMascot', () {
    test(
      'should add the provided mascot to the repository with the expression ids only',
      () async {
        // act
        final result = await usecase(newMascot).single;
        var newMascotWithExpressionIds = newMascot.copyWith(
          expressions: newMascot.expressions
              .map((e) => Expression.empty.copyWith(id: e.id))
              .toSet(),
        );

        // assert
        expect(result, updatedMascot);
        verifyInOrder([
          context.mocks.mascotsRepository
              .saveMascot(newMascotWithExpressionIds),
          context.mocks.mascotsRepository.getMascot(context.data.mascot.id),
        ]);
        verifyNoMoreInteractions(context.mocks.mascotsRepository);
      },
    );

    test('should update favorite mascot when adding a new mascot', () async {
      // act
      await usecase(newMascot).single;

      // assert
      verify(context.mocks.settingsRepository.loadSettings());
      verify(context.mocks.settingsRepository.setFavoriteMascotId(
        context.data.mascot.id,
      ));
    });

    test(
      'should not update favorite mascot when favorite mascot is already set',
      () async {
        // arrange
        when(context.mocks.settingsRepository.loadSettings())
            .thenAnswer((_) => Single.value(context.data.settings));

        // act
        await usecase(newMascot).single;

        // assert
        verify(context.mocks.settingsRepository.loadSettings());
        verifyNever(context.mocks.settingsRepository.setFavoriteMascotId(
          context.data.mascot.id,
        ));
      },
    );
  });
}
