import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/usecase.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/settings/presentation/bloc/effects/stream_settings_effect.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late StreamSettingsEffect effect;

  setUp(() {
    context = TestContext();
    effect = StreamSettingsEffect(context.mocks.streamSettings);

    when(context.mocks.streamSettings(any)).thenAnswer(
      (_) async => Right(BehaviorSubject.seeded(context.data.settings)),
    );
  });

  group('SettingsBloc StreamSettingsEffect', () {
    test(
      'should invoke StreamSettings',
      () async {
        // arrange
        final event = LoadSettingsEvent();
        final state = SettingsInitial();

        // act
        await effect(event, state).take(2).toList();

        // assert
        verify(context.mocks.streamSettings(NoParams()));
      },
    );

    test(
        'should return [LoadingSettings, SettingsUpdated] when settings is loaded',
        () async {
      // arrange
      final event = LoadSettingsEvent();
      final state = SettingsInitial();

      // act
      final result = effect(event, state);
      var events = await result.take(2).toList();

      // assert
      expect(
        events,
        [
          const LoadingSettingsEvent(),
          SettingsUpdatedEvent(context.data.settings),
        ],
      );
    });

    test(
        'should return [LoadingSettings, StreamSettingsError] when settings fails',
        () async {
      // arrange
      final event = LoadSettingsEvent();
      final state = SettingsInitial();

      when(context.mocks.streamSettings(any)).thenAnswer(
        (_) async => Left(LocalDataSourceFailure()),
      );

      // act
      final result = effect(event, state);
      var events = await result.take(2).toList();

      // assert
      expect(
        events,
        [
          const LoadingSettingsEvent(),
          LoadSettingsFailureEvent(LocalDataSourceFailure()),
        ],
      );
    });
  });
}
