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
  const talkingThreshold = DecibelLufs(-10);

  setUp(() {
    context = TestContext();
    settingsStream = BehaviorSubject.seeded(context.data.settings);
    microphoneVolumeStream = BehaviorSubject.seeded(talkingThreshold);
    trigger = TalkingExpressionTrigger(
      context.data.expression,
      context.mocks.settingsRepository,
      context.mocks.streamMicrophoneVolume,
    );

    when(context.mocks.settingsRepository.streamSettings())
        .thenAnswer((_) => settingsStream);
    when(context.mocks.streamMicrophoneVolume(any))
        .thenAnswer((_) => microphoneVolumeStream);
  });

  group('TalkingExpressionTrigger', () {
    test('isTriggered should return false', () {
      // assert
      expect(trigger.isTriggered, isFalse);
    });

    group('stream', () {
      test('should return stream with this trigger', () async {
        // act
        var stream = trigger.stream;

        // assert
        expect(await stream.first, trigger);
      });

      test('should emit [trigger.isTriggered = false] when created', () async {
        // arrange
        var stream = trigger.stream;

        // assert
        expect(await stream.first, trigger);
        expect(trigger.isTriggered, isFalse);
      });

      test(
        'should emit [trigger.isTriggered = true] when microphone volume is above threshold',
        () async {
          // arrange
          var stream = trigger.stream;

          // act
          microphoneVolumeStream.add(const DecibelLufs(-9));

          // assert
          expect(await stream.skip(1).first, trigger);
          expect(trigger.isTriggered, isTrue);
        },
      );

      test(
        'should emit [trigger.isTriggered = true] when microphone volume is at threshold',
        () async {
          // arrange
          var stream = trigger.stream;

          // act
          microphoneVolumeStream.add(const DecibelLufs(-10));

          // assert
          expect(await stream.skip(1).first, trigger);
          expect(trigger.isTriggered, isTrue);
        },
      );

      test(
        'should emit [trigger.isTriggered = false] when microphone volume is below threshold',
        () async {
          // arrange
          var stream = trigger.stream;
          microphoneVolumeStream.add(const DecibelLufs(-9));

          // act
          microphoneVolumeStream.add(const DecibelLufs(-11));

          // assert
          expect(await stream.first, trigger);
          expect(trigger.isTriggered, isFalse);
        },
      );

      test('should update talking threshold when settings change', () async {
        // arrange
        var stream = trigger.stream;
        microphoneVolumeStream.add(const DecibelLufs(-9));

        // act
        settingsStream.add(context.data.settings.copyWith(
          talkingThreshold: const DecibelLufs(-8),
        ));

        // assert
        expect(await stream.first, trigger);
        expect(trigger.isTriggered, isFalse);
      });

      test('should not emit when trigger state does not change', () async {
        // arrange
        var stream = trigger.stream;
        microphoneVolumeStream.add(const DecibelLufs(-9));
        await Future.delayed(const Duration(milliseconds: 25));

        // act
        microphoneVolumeStream.add(const DecibelLufs(-8));

        // assert
        expect(stream, emitsInOrder([trigger]));
      });
    });
  });
}
