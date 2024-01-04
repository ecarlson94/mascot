import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late StreamMascot useCase;

  setUp(() {
    context = TestContext();
    useCase = StreamMascot(context.mocks.mascotsRepository);
  });

  group('StreamMascot', () {
    test('should call repository', () async {
      // arrange
      var mascot = context.data.mascot;
      when(context.mocks.mascotsRepository.streamMascot(mascot.id))
          .thenAnswer((_) => Single.value(mascot));

      // act
      await useCase(1).single;

      // assert
      verify(context.mocks.mascotsRepository.streamMascot(mascot.id));
    });
  });
}
