part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final Option<BehaviorSubject<Id>> favoriteMascotIdStreamOption;

  const SettingsState(this.favoriteMascotIdStreamOption);

  @override
  List<Object> get props => [favoriteMascotIdStreamOption];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(super.favoriteMascotIdStreamOption);
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(super.favoriteMascotIdStreamOptionn);
}

class SettingsError extends SettingsState {
  final int errorCode;

  const SettingsError(
    this.errorCode,
    super.favoriteMascotIdStreamOptionn,
  );

  @override
  List<Object> get props => [errorCode, favoriteMascotIdStreamOption];
}
