import 'package:dartz/dartz.dart';

import '../../../../../core/error/error.dart';
import '../../../../../core/error/failure.dart';
import 'microphone_volume_bloc.dart';

MicrophoneVolumeState loadingVolumeStream(
  LoadingVolumeStreamEvent event,
  MicrophoneVolumeState currentState,
) {
  return MicrophoneVolumeLoading(currentState.volumeOption);
}

MicrophoneVolumeState microphoneVolumeUpdated(
  MicrophoneVolumeUpdatedEvent event,
  MicrophoneVolumeState currentState,
) {
  return MicrophoneVolumeLoaded(some(event.volume));
}

MicrophoneVolumeState streamVolumeFailure(
  StreamVolumeFailureEvent event,
  MicrophoneVolumeState currentState,
) {
  return MicrophoneVolumeError(
    _mapMicFailureToErrorCode(event.failure),
    currentState.volumeOption,
  );
}

int _mapMicFailureToErrorCode(Failure failure) {
  if (failure is NoMicrophonePermissionFailure) {
    return ErrorCodes.noMicrophonePermissionFailureCode;
  }
  if (failure is MicrophoneFailure) return ErrorCodes.microphoneFailureCode;
  return ErrorCodes.unknownFailureCode;
}
