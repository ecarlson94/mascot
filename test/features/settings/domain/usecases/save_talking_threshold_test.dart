import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/domain/usecases/save_talking_threshold.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SaveTalkingThreshold usecase;

  setUp(() {
    context = TestContext();
    usecase = SaveTalkingThreshold(context.mocks.settingsRepository);
  });

  group('SaveTalkingThreshold', () {
    test('should call the repository to set the talking threshold', () async {
      // arrange
      when(context.mocks.settingsRepository.setTalkingThreshold(any))
          .thenAnswer((_) => Single.value(unit));
      const threshold = DecibelLufs(12);

      // act
      final result = await usecase(threshold).single;

      // assert
      expect(result, unit);
      verify(context.mocks.settingsRepository.setTalkingThreshold(threshold));
      verifyNoMoreInteractions(context.mocks.settingsRepository);
    });
  });
}
