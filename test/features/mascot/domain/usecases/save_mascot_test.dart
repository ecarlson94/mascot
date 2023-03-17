import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SaveMascot usecase;
  late Mascot updatedMascot;

  setUp(() {
    context = TestContext();
    usecase = SaveMascot(
      context.mocks.mascotsRepository,
      context.mocks.settingsRepository,
    );
    updatedMascot = context.data.mascot.copyWith(
      name: 'Updated name',
    );

    when(context.mocks.mascotsRepository.addMascot(any))
        .thenAnswer((_) async => Right(context.data.mascot.id));
    when(context.mocks.settingsRepository.loadSettings())
        .thenAnswer((_) async => const Right(Settings.empty));
    when(context.mocks.settingsRepository.setFavoriteMascotId(any))
        .thenAnswer((_) async => const Right(unit));
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) async => Right(updatedMascot));
  });

  test(
    'SaveMascot usecase should add the provided mascot to the repository',
    () async {
      // act
      final result = await usecase(context.data.mascot);

      // assert
      expect(result, Right(updatedMascot));
      verifyInOrder([
        context.mocks.mascotsRepository.addMascot(context.data.mascot),
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
}
