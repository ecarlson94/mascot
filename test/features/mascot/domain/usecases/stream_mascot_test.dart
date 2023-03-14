import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

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
      var stream = BehaviorSubject.seeded(mascot);
      when(context.mocks.mascotsRepository.streamMascot(mascot.id))
          .thenAnswer((_) async => Right(stream));

      // act
      await useCase(1);

      // assert
      verify(context.mocks.mascotsRepository.streamMascot(mascot.id));
    });
  });
}
