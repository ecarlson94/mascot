import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_actions.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart';

void main() {
  group('MicrophoneVolumeBloc', () {
    group('loadingVolumeStream', () {
      test('should return MicrophoneVolumeLoading', () {
        // assemble
        var state = MicrophoneVolumeInitial();

        // act
        var result = loadingVolumeStream(
          const LoadingVolumeStreamEvent(),
          state,
        );

        // assert
        expect(result, MicrophoneVolumeLoading(none()));
      });

      test('should use the volumeOption of the current state', () {
        // assemble
        const decibels = DecibelLufs(2);
        var state = MicrophoneVolumeLoaded(some(decibels));

        // act
        var result = loadingVolumeStream(
          const LoadingVolumeStreamEvent(),
          state,
        );

        // assert
        expect(result, MicrophoneVolumeLoading(some(decibels)));
      });
    });

    group('microphoneVolumeUpdated', () {
      test('should return MicrophoneVolumeLoaded', () {
        // assemble
        const decibels = DecibelLufs(2);
        var state = MicrophoneVolumeInitial();

        // act
        var result = microphoneVolumeUpdated(
          const MicrophoneVolumeUpdatedEvent(decibels),
          state,
        );

        // assert
        expect(result, MicrophoneVolumeLoaded(some(decibels)));
      });
    });

    group('streamVolumeFailure', () {
      test('should use the volumeOption of the current state', () {
        // assemble
        const decibels = DecibelLufs(2);
        var state = MicrophoneVolumeLoaded(some(decibels));

        // act
        var result = streamVolumeFailure(
          const StreamVolumeFailureEvent(
              ErrorCodes.microphonePermissionFailure),
          state,
        );

        // assert
        expect(
          result,
          MicrophoneVolumeError(
            ErrorCodes.microphonePermissionFailure,
            some(decibels),
          ),
        );
      });
    });
  });
}
