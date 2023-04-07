import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';

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
        .thenAnswer((_) async => Right(context.data.mascot.id));
    when(context.mocks.settingsRepository.loadSettings())
        .thenAnswer((_) async => const Right(Settings.empty));
    when(context.mocks.settingsRepository.setFavoriteMascotId(any))
        .thenAnswer((_) async => const Right(unit));
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) async => Right(updatedMascot));
    when(context.mocks.expressionsRepository.saveExpressions(any)).thenAnswer(
      (_) async => Right(newMascot.expressions.map((e) => e.id).toList()),
    );
    when(context.mocks.expressionsRepository.getExpressions(any))
        .thenAnswer((_) async => Right(newMascot.expressions.toList()));
  });

  group('AddMascot', () {
    test(
      'should add the provided mascot to the repository with the expression ids only',
      () async {
        // act
        final result = await usecase(newMascot);
        var newMascotWithExpressionIds = newMascot.copyWith(
          expressions: newMascot.expressions
              .map((e) => Expression.empty.copyWith(id: e.id))
              .toSet(),
        );

        // assert
        expect(result, Right(updatedMascot));
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
      await usecase(newMascot);

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
        await usecase(newMascot);

        // assert
        verify(context.mocks.settingsRepository.loadSettings());
        verifyNever(context.mocks.settingsRepository.setFavoriteMascotId(
          context.data.mascot.id,
        ));
      },
    );

    test(
      'should return InvalidArgumentFailure when mascot already exists',
      () async {
        // act
        final result = await usecase(newMascot.copyWith(id: 1));

        // assert
        expect(result, Left(InvalidArgumentFailure()));
      },
    );
  });
}
