part of 'microphone_volume_bloc.dart';

abstract class MicrophoneVolumeEvent extends Equatable {
  const MicrophoneVolumeEvent();

  @override
  List<Object> get props => [];
}

class InitializeMicrophoneVolume extends MicrophoneVolumeEvent {}

class MicrophoneVolumeUpdated extends MicrophoneVolumeEvent {
  final DecibelLufs volume;

  const MicrophoneVolumeUpdated(this.volume);

  @override
  List<Object> get props => [volume];
}

class StreamVolumeFailure extends MicrophoneVolumeEvent {
  final Failure failure;

  const StreamVolumeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class LoadingVolumeStream extends MicrophoneVolumeEvent {
  const LoadingVolumeStream();
}
