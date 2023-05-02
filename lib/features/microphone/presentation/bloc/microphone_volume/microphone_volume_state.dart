part of 'microphone_volume_bloc.dart';

abstract class MicrophoneVolumeState extends Equatable {
  final Option<DecibelLufs> volumeOption;

  const MicrophoneVolumeState(this.volumeOption);

  @override
  List<Object> get props => [volumeOption];
}

class MicrophoneVolumeInitial extends MicrophoneVolumeState {
  const MicrophoneVolumeInitial(super.volumeOption);
}

class MicrophoneVolumeLoading extends MicrophoneVolumeState {
  const MicrophoneVolumeLoading(super.volumeOption);
}

class MicrophoneVolumeLoaded extends MicrophoneVolumeState {
  const MicrophoneVolumeLoaded(super.volumeOption);
}

class MicrophoneVolumeError extends MicrophoneVolumeState {
  final int errorCode;

  const MicrophoneVolumeError(this.errorCode, super.volumeOption);
}
