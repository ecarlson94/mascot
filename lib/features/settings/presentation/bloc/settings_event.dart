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

class SettingsUpdatedEvent extends SettingsEvent {
  final Settings settings;

  const SettingsUpdatedEvent(this.settings);

  @override
  List<Object?> get props => [settings, ...super.props];
}

class LoadingSettingsEvent extends SettingsEvent {
  const LoadingSettingsEvent();
}

class LoadSettingsFailureEvent extends SettingsEvent {
  final int errorCode;

  const LoadSettingsFailureEvent(this.errorCode);

  @override
  List<Object?> get props => [errorCode, ...super.props];
}
