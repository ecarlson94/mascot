import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SaveMascot usecase;

  setUp(() {
    context = TestContext();
    usecase = SaveMascot(context.mocks.mascotsRepository);
  });

  test(
    'SaveMascot usecase should add the provided mascot to the repository',
    () async {
      // arrange
      when(context.mocks.mascotsRepository.addMascot(any))
          .thenAnswer((_) async => Right(context.data.mascot.id));

      // act
      final result = await usecase(context.data.mascot);

      // assert
      expect(result, Right(context.data.mascot.id));
      verify(context.mocks.mascotsRepository.addMascot(context.data.mascot));
      verifyNoMoreInteractions(context.mocks.mascotsRepository);
    },
  );
}
