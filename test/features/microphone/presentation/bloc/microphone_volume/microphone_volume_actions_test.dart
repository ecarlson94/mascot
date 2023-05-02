import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_actions.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart';

void main() {
  group('MicrophoneVolumeBloc', () {
    group('loadingVolumeStream', () {
      test('should return MicrophoneVolumeLoading', () {
        // assemble
        var state = MicrophoneVolumeInitial(none());

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
        var state = MicrophoneVolumeInitial(some(decibels));

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
        var state = MicrophoneVolumeInitial(none());

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
      var failureToErrorCodes = {
        NoMicrophonePermissionFailure():
            ErrorCodes.noMicrophonePermissionFailureCode,
        MicrophoneFailure(): ErrorCodes.microphoneFailureCode,
        LocalDataSourceFailure(): ErrorCodes.unknownFailureCode,
      };

      for (var entry in failureToErrorCodes.entries) {
        test(
          'should return MicrophoneVolumeError with error code ${entry.value} when failure is ${entry.key.runtimeType}',
          () {
            // assemble
            var state = MicrophoneVolumeInitial(none());

            // act
            var result = streamVolumeFailure(
              StreamVolumeFailureEvent(entry.key),
              state,
            );

            // assert
            expect(
              result,
              MicrophoneVolumeError(entry.value, none()),
            );
          },
        );
      }

      test('should use the volumeOption of the current state', () {
        // assemble
        const decibels = DecibelLufs(2);
        var state = MicrophoneVolumeInitial(some(decibels));

        // act
        var result = streamVolumeFailure(
          StreamVolumeFailureEvent(MicrophoneFailure()),
          state,
        );

        // assert
        expect(
          result,
          MicrophoneVolumeError(
            ErrorCodes.microphoneFailureCode,
            some(decibels),
          ),
        );
      });
    });
  });
}
