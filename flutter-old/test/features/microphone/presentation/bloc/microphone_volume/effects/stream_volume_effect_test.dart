import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/usecase.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late StreamVolumeEffect effect;
  late Stream<DecibelLufs> volumeStream;
  const DecibelLufs twentyDecibels = DecibelLufs(20);
  const DecibelLufs thirtyDecibels = DecibelLufs(30);

  setUp(() {
    context = TestContext();
    effect = StreamVolumeEffect(context.mocks.streamMicrophoneVolume);
    volumeStream = Stream.fromIterable([
      twentyDecibels,
      thirtyDecibels,
    ]);

    when(context.mocks.streamMicrophoneVolume(any)).thenAnswer(
      (_) => volumeStream,
    );
  });

  group('MicrophoneVolumeBloc StreamVolumeEffect', () {
    test(
      'should invoke StreamMicrophoneVolume',
      () async {
        // arrange
        final event = InitializeMicrophoneVolumeEvent();
        final state = MicrophoneVolumeLoaded(some(twentyDecibels));

        // act
        var result = await effect(event, state).toList();

        // assert
        expect(result.length, 3);
        verify(context.mocks.streamMicrophoneVolume(NoParams()));
      },
    );

    test(
      'should map volume stream to MicrophoneVolumeUpdated events',
      () async {
        // arrange
        final event = InitializeMicrophoneVolumeEvent();
        final state = MicrophoneVolumeLoaded(some(twentyDecibels));

        // act
        final result = await effect(event, state).toList();

        // assert
        expect(result, const [
          LoadingVolumeStreamEvent(),
          MicrophoneVolumeUpdatedEvent(twentyDecibels),
          MicrophoneVolumeUpdatedEvent(thirtyDecibels)
        ]);
      },
    );

    test(
      'should return [LoadingVolumeStream, StreamVolumeFailure(${ErrorCodes.microphonePermissionFailure})] events microphone permission is denied',
      () async {
        // arrange
        final event = InitializeMicrophoneVolumeEvent();
        final state = MicrophoneVolumeLoaded(some(twentyDecibels));

        when(context.mocks.streamMicrophoneVolume(any)).thenAnswer(
          (_) => Stream.error(const MicrophonePermissionException()),
        );

        // act
        final result = await effect(event, state).toList();

        // assert
        expect(result, [
          const LoadingVolumeStreamEvent(),
          const StreamVolumeFailureEvent(
            ErrorCodes.microphonePermissionFailure,
          ),
        ]);
      },
    );

    test(
      'should return [LoadingVolumeStream, StreamVolumeFailure(${ErrorCodes.unknownFailure})] events when stream fails',
      () async {
        // arrange
        final event = InitializeMicrophoneVolumeEvent();
        final state = MicrophoneVolumeLoaded(some(twentyDecibels));

        when(context.mocks.streamMicrophoneVolume(any)).thenAnswer(
          (_) => Stream.error(const OutOfMemoryError()),
        );

        // act
        final result = await effect(event, state).toList();

        // assert
        expect(result, [
          const LoadingVolumeStreamEvent(),
          const StreamVolumeFailureEvent(
            ErrorCodes.unknownFailure,
          ),
        ]);
      },
    );
  });
}
