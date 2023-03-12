import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SaveMascot usecase;

  setUp(() {
    context = TestContext();
    usecase = SaveMascot(
      context.mocks.mascotsRepository,
      context.mocks.settingsRepository,
    );

    when(context.mocks.mascotsRepository.addMascot(any))
        .thenAnswer((_) async => Right(context.data.mascot.id));
    when(context.mocks.settingsRepository.loadSettings())
        .thenAnswer((_) async => const Right(Settings(favoriteMascotId: 0)));
    when(context.mocks.settingsRepository.setFavoriteMascotId(any))
        .thenAnswer((_) async => const Right(unit));
  });

  test(
    'SaveMascot usecase should add the provided mascot to the repository',
    () async {
      // act
      final result = await usecase(context.data.mascot);

      // assert
      expect(result, Right(context.data.mascot.id));
      verify(context.mocks.mascotsRepository.addMascot(context.data.mascot));
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
