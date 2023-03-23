part of 'microphone_volume_bloc.dart';

abstract class MicrophoneVolumeState extends Equatable {
  final Option<Stream<DecibelLufs>> volumeStreamOption;

  const MicrophoneVolumeState(this.volumeStreamOption);

  @override
  List<Object> get props => [volumeStreamOption];
}

class MicrophoneVolumeInitial extends MicrophoneVolumeState {
  const MicrophoneVolumeInitial(super.volumeStreamOption);
}

class MicrophoneVolumeLoading extends MicrophoneVolumeState {
  const MicrophoneVolumeLoading(super.volumeStreamOption);
}

class MicrophoneVolumeLoaded extends MicrophoneVolumeState {
  const MicrophoneVolumeLoaded(super.volumeStreamOption);
}

class MicrophoneVolumeError extends MicrophoneVolumeState {
  final int errorCode;

  const MicrophoneVolumeError(this.errorCode, super.volumeStreamOption);
}
