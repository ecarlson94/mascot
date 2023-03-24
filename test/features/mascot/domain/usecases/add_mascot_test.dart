import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late AddMascot usecase;
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

    when(context.mocks.mascotsRepository.saveMascot(any))
        .thenAnswer((_) async => Right(context.data.mascot.id));
    when(context.mocks.settingsRepository.loadSettings())
        .thenAnswer((_) async => const Right(Settings.empty));
    when(context.mocks.settingsRepository.setFavoriteMascotId(any))
        .thenAnswer((_) async => const Right(unit));
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) async => Right(updatedMascot));
    when(context.mocks.expressionsRepository.saveExpressions(any))
        .thenAnswer((_) async => const Right([]));
    when(context.mocks.expressionsRepository.getExpressions(any))
        .thenAnswer((_) async => const Right([]));
  });

  group('AddMascot', () {
    test(
      'should add the provided mascot to the repository',
      () async {
        // act
        final result = await usecase(context.data.mascot);

        // assert
        expect(result, Right(updatedMascot));
        verifyInOrder([
          context.mocks.mascotsRepository.saveMascot(context.data.mascot),
          context.mocks.mascotsRepository.getMascot(context.data.mascot.id),
        ]);
        verifyNoMoreInteractions(context.mocks.mascotsRepository);
      },
    );

    test('should update favorite mascot when adding a new mascot', () async {
      // act
      await usecase(context.data.mascot);

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
            .thenAnswer((_) async => Right(context.data.settings));

        // act
        await usecase(context.data.mascot);

        // assert
        verify(context.mocks.settingsRepository.loadSettings());
        verifyNever(context.mocks.settingsRepository.setFavoriteMascotId(
          context.data.mascot.id,
        ));
      },
    );

    test(
      'should ensure that expressions are saved before adding mascot',
      () async {
        // arrange
        var unsavedExpression = context.data.expression.copyWith(id: 0);
        var unsafeMascot = context.data.mascot.copyWith(
          expressions: {
            ...context.data.mascot.expressions,
            unsavedExpression,
          },
        );
        var savedExpression = context.data.expression.copyWith(id: 20);
        var safeMascot = context.data.mascot.copyWith(
          expressions: {
            ...context.data.mascot.expressions,
            savedExpression,
          },
        );
        when(context.mocks.expressionsRepository.getExpressions(any))
            .thenAnswer((_) async => Right([savedExpression]));

        // act
        await usecase(unsafeMascot);

        // assert
        verify(
          context.mocks.mascotsRepository.saveMascot(safeMascot),
        );
      },
    );
  });
}
