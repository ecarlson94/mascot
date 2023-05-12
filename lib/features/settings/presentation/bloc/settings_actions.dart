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
    );

SettingsState settingsUpdated(
  SettingsUpdatedEvent event,
  SettingsState state,
) =>
    SettingsLoaded(
      some(event.settings.favoriteMascotId),
      some(event.settings.talkingThreshold),
    );

SettingsState loadingSettings(
  LoadingSettingsEvent event,
  SettingsState state,
) =>
    LoadingSettings(
      state.favoriteMascotIdOption,
      state.talkingThresholdOption,
    );
