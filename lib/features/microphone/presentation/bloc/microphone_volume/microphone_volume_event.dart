part of 'microphone_volume_bloc.dart';

abstract class MicrophoneVolumeEvent extends Equatable {
  const MicrophoneVolumeEvent();

  @override
  List<Object> get props => [];
}

class InitializeMicrophoneVolumeEvent extends MicrophoneVolumeEvent {}

class MicrophoneVolumeUpdatedEvent extends MicrophoneVolumeEvent {
  final DecibelLufs volume;

  const MicrophoneVolumeUpdatedEvent(this.volume);

  @override
  List<Object> get props => [volume];
}

class StreamVolumeFailureEvent extends MicrophoneVolumeEvent {
  final Failure failure;

  const StreamVolumeFailureEvent(this.failure);

  @override
  List<Object> get props => [failure];
}

class LoadingVolumeStreamEvent extends MicrophoneVolumeEvent {
  const LoadingVolumeStreamEvent();
}
