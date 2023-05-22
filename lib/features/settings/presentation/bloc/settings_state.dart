part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final Option<Id?> favoriteMascotIdOption;
  final Option<DecibelLufs?> talkingThresholdOption;
  final Option<RecordSettings> recordSettingsOption;

  const SettingsState(
    this.favoriteMascotIdOption,
    this.talkingThresholdOption,
    this.recordSettingsOption,
  );

  @override
  List<Object> get props => [
        favoriteMascotIdOption,
        talkingThresholdOption,
        recordSettingsOption,
      ];
}

class SettingsInitial extends SettingsState {
  SettingsInitial()
      : super(
          none(),
          none(),
          none(),
        );
}

class LoadingSettings extends SettingsState {
  const LoadingSettings(
    super.favoriteMascotIdStreamOption,
    super.talkingThresholdStreamOption,
    super.recordSettingsOption,
  );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(
    super.favoriteMascotIdStreamOption,
    super.talkingThresholdStreamOption,
    super.recordSettingsOption,
  );
}

class SettingsError extends SettingsState {
  final int errorCode;

  const SettingsError(
    this.errorCode,
    super.favoriteMascotIdStreamOptionn,
    super.talkingThresholdStreamOption,
    super.recordSettingsOption,
  );

  @override
  List<Object> get props => [errorCode, ...super.props];
}
