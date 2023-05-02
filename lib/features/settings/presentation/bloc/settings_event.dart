part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class SetTalkingThresholdEvent extends SettingsEvent {
  final DecibelLufs talkingThreshold;

  const SetTalkingThresholdEvent(this.talkingThreshold);

  @override
  List<Object?> get props => [talkingThreshold, ...super.props];
}
