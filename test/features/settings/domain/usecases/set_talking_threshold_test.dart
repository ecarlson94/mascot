import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/domain/usecases/set_talking_threshold.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SetTalkingThreshold usecase;

  setUp(() {
    context = TestContext();
    usecase = SetTalkingThreshold(context.mocks.settingsRepository);
  });

  group('SetTalkingThreshold', () {
    test('should call the repository to set the talking threshold', () async {
      // arrange
      when(context.mocks.settingsRepository.setTalkingThreshold(any))
          .thenAnswer((_) async => const Right(unit));
      const threshold = DecibelLufs(12);

      // act
      final result = await usecase(threshold);

      // assert
      expect(result, const Right(unit));
      verify(context.mocks.settingsRepository.setTalkingThreshold(threshold));
      verifyNoMoreInteractions(context.mocks.settingsRepository);
    });
  });
}
