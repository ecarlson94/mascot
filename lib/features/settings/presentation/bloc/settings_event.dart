part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class SetTalkingThreshold extends SettingsEvent {
  final DecibelLufs talkingThreshold;

  const SetTalkingThreshold(this.talkingThreshold);

  @override
  List<Object?> get props => [talkingThreshold, ...super.props];
}
