import 'package:dartz/dartz.dart';

import 'settings_bloc.dart';

SettingsState loadSettingsFailure(
  LoadSettingsFailureEvent event,
  SettingsState state,
) =>
    SettingsError(
      event.errorCode,
      state.favoriteMascotIdOption,
      state.talkingThresholdOption,
      state.recordSettingsOption,
    );

SettingsState settingsUpdated(
  SettingsUpdatedEvent event,
  SettingsState state,
) =>
    SettingsLoaded(
      some(event.settings.favoriteMascotId),
      some(event.settings.talkingThreshold),
      some(event.settings.recordSettings),
    );

SettingsState loadingSettings(
  LoadingSettingsEvent event,
  SettingsState state,
) =>
    LoadingSettings(
      state.favoriteMascotIdOption,
      state.talkingThresholdOption,
      state.recordSettingsOption,
    );
