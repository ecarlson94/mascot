import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SetTalkingThresholdEffect effect;

  setUp(() {
    context = TestContext();
    effect = SetTalkingThresholdEffect(context.mocks.saveTalkingThreshold);

    when(context.mocks.saveTalkingThreshold(any)).thenAnswer(
      (_) async => const Right(unit),
    );
  });

  group('SettingsBloc SetTalkingThresholdEffect', () {
    test(
      'should invoke SaveTalkingThreshold with threshold',
      () async {
        // arrange
        var decibels = const DecibelLufs(10);
        final event = SetTalkingThresholdEvent(decibels);
        final state = SettingsInitial();

        // act
        var events = await effect(event, state).toList();

        // assert
        expect(events.isEmpty, isTrue);
        verify(context.mocks.saveTalkingThreshold(decibels));
      },
    );
  });
}
