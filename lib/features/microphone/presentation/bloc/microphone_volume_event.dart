part of 'microphone_volume_bloc.dart';

abstract class MicrophoneVolumeEvent extends Equatable {
  const MicrophoneVolumeEvent();

  @override
  List<Object> get props => [];
}

class InitializeMicrophoneVolume extends MicrophoneVolumeEvent {}
