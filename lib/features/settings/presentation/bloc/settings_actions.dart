import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import 'settings_bloc.dart';

SettingsState loadSettingsFailure(
  LoadSettingsFailureEvent event,
  SettingsState state,
) =>
    SettingsError(
      ErrorCodes.loadSettingsFailureCode,
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
