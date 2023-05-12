part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final Option<Id?> favoriteMascotIdOption;
  final Option<DecibelLufs?> talkingThresholdOption;

  const SettingsState(
    this.favoriteMascotIdOption,
    this.talkingThresholdOption,
  );

  @override
  List<Object> get props => [
        favoriteMascotIdOption,
        talkingThresholdOption,
      ];
}

class SettingsInitial extends SettingsState {
  SettingsInitial()
      : super(
          none(),
          none(),
        );
}

class LoadingSettings extends SettingsState {
  const LoadingSettings(
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
