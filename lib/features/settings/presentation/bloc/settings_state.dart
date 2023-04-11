part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final Option<BehaviorSubject<Id?>> favoriteMascotIdStreamOption;
  final Option<BehaviorSubject<DecibelLufs?>> talkingThresholdStreamOption;

  const SettingsState(
    this.favoriteMascotIdStreamOption,
    this.talkingThresholdStreamOption,
  );

  @override
  List<Object> get props => [
        favoriteMascotIdStreamOption,
        talkingThresholdStreamOption,
      ];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(
    super.favoriteMascotIdStreamOption,
    super.talkingThresholdStreamOption,
  );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(
    super.favoriteMascotIdStreamOption,
    super.talkingThresholdStreamOption,
  );
}

class SettingsError extends SettingsState {
  final int errorCode;

  const SettingsError(
    this.errorCode,
    super.favoriteMascotIdStreamOptionn,
    super.talkingThresholdStreamOption,
  );

  @override
  List<Object> get props => [errorCode, ...super.props];
}
