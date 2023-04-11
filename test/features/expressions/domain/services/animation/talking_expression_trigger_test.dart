import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/services/animation/talking_expression_trigger.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late TalkingExpressionTrigger trigger;
  late BehaviorSubject<Settings> settingsStream;
  late BehaviorSubject<DecibelLufs> microphoneVolumeStream;

  setUp(() {
    context = TestContext();
    settingsStream = BehaviorSubject.seeded(context.data.settings);
    microphoneVolumeStream = BehaviorSubject.seeded(const DecibelLufs(-10));
    trigger = TalkingExpressionTrigger(
      context.data.expression,
      context.mocks.settingsRepository,
      context.mocks.streamMicrophoneVolume,
    );

    when(context.mocks.settingsRepository.streamSettings())
        .thenAnswer((_) async => Right(settingsStream));
    when(context.mocks.streamMicrophoneVolume(any))
        .thenAnswer((_) async => Right(microphoneVolumeStream));
  });

  group('TalkingExpressionTrigger', () {
    test('isTriggered should return false', () {
      // assert
      expect(trigger.isTriggered, isFalse);
    });

    test('should return stream with this trigger', () async {
      // act
      var stream = await trigger.stream;

      // assert
      expect(await stream.first, trigger);
    });

    group('stream', () {});
  });
}
