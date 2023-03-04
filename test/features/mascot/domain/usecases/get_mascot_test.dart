import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late GetMascot usecase;

  setUp(() {
    context = TestContext();
    usecase = GetMascot(context.mocks.mascotsRepository);
  });

  test('should get the mascot from the repository', () async {
    // arrange
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) async => Right(context.data.mascot));

    // act
    final result = await usecase(1);

    // assert
    expect(result, Right(context.data.mascot));
    verify(context.mocks.mascotsRepository.getMascot(1));
    verifyNoMoreInteractions(context.mocks.mascotsRepository);
  });
}
