import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_actions.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late Settings settings;

  setUp(() {
    settings = TestContext().data.settings;
  });

  group('SettingsBloc', () {
    group('settingsUpdated', () {
      test('should return SettingsLoaded', () {
        // assemble
        var state = SettingsInitial();

        // act
        var result = settingsUpdated(
          SettingsUpdatedEvent(settings),
          state,
        );

        // assert
        expect(
          result,
          SettingsLoaded(
            some(settings.favoriteMascotId),
            some(settings.talkingThreshold),
          ),
        );
      });
    });

    group('loadSettingsFailure', () {
      test('should return SettingsError with current state', () {
        // assemble
        var state = SettingsLoaded(
          some(settings.favoriteMascotId),
          some(settings.talkingThreshold),
        );

        // act
        var result = loadSettingsFailure(
          const LoadSettingsFailureEvent(ErrorCodes.loadSettingsFailure),
          state,
        );

        // assert
        expect(
          result,
          SettingsError(
            ErrorCodes.loadSettingsFailure,
            state.favoriteMascotIdOption,
            state.talkingThresholdOption,
          ),
        );
      });
    });
  });
}
