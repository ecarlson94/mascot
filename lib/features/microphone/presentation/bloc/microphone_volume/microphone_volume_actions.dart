import 'package:dartz/dartz.dart';

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
    event.errorCode,
    currentState.volumeOption,
  );
}
