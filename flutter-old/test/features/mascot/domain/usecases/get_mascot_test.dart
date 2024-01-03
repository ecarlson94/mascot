import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late GetMascot usecase;

  setUp(() {
    context = TestContext();
    usecase = GetMascot(context.mocks.mascotsRepository);
  });

  test('GetMascot usecase should get the mascot from the repository', () async {
    // arrange
    when(context.mocks.mascotsRepository.getMascot(any))
        .thenAnswer((_) => Single.value(context.data.mascot));

    // act
    final result = await usecase(1).single;

    // assert
    expect(result, context.data.mascot);
    verify(context.mocks.mascotsRepository.getMascot(1));
    verifyNoMoreInteractions(context.mocks.mascotsRepository);
  });
}
