import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  group('SettingsBloc', () {
    late TestContext context;
    late SettingsBloc bloc;
    late BehaviorSubject<Settings> settingsSubject;
    late BehaviorSubject<int?> favoriteMascotIdSubject;
    late BehaviorSubject<DecibelLufs?> talkingThresholdSubject;

    setUp(() {
      context = TestContext();
      bloc = SettingsBloc(
        context.mocks.streamSettings,
        context.mocks.saveTalkingThreshold,
      );
      settingsSubject = BehaviorSubject<Settings>.seeded(context.data.settings);
      favoriteMascotIdSubject =
          BehaviorSubject.seeded(context.data.settings.favoriteMascotId);
      talkingThresholdSubject =
          BehaviorSubject.seeded(context.data.settings.talkingThreshold);

      when(context.mocks.streamSettings(any))
          .thenAnswer((_) async => Right(settingsSubject));
    });

    test('initialState should be SettingsInitial', () {
      // assert
      expect(bloc.state, SettingsInitial(none(), none()));
    });

    group('SetTalkingThreshold', () {
      blocTest(
        'should invoke the save talking threshold usecase',
        build: () => bloc,
        setUp: () {
          when(context.mocks.saveTalkingThreshold(any))
              .thenAnswer((_) async => const Right(unit));
        },
        act: (bloc) =>
            bloc.add(const SetTalkingThresholdEvent(DecibelLufs(12))),
        verify: (bloc) {
          verify(context.mocks.saveTalkingThreshold(const DecibelLufs(12)));
          verifyNoMoreInteractions(context.mocks.saveTalkingThreshold);
        },
      );
    });

    group('LoadSettings', () {
      blocTest(
        'should emit [SettingsLoaded] when retrieval of settings is successful',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        expect: () => [
          isA<SettingsLoaded>(),
        ],
      );

      blocTest(
        'should use the stream settings usecase',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        verify: (bloc) => verify(context.mocks.streamSettings(any)),
      );

      blocTest(
        'should create streams for individual settings',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        verify: (bloc) {
          var settingStreamOption = bloc.state.favoriteMascotIdStreamOption;
          expect(settingStreamOption, isSome);
          var stream = settingStreamOption.getOrFailTest();
          expect(stream.hasValue, isTrue);
          expect(stream.value, context.data.settings.favoriteMascotId);
        },
      );

      blocTest(
        'should ignore individual settings updates when the value is the same',
        build: () => bloc,
        setUp: () => settingsSubject.add(context.data.settings),
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        verify: (bloc) {
          expect(
            bloc.state.favoriteMascotIdStreamOption.getOrFailTest(),
            emits(context.data.settings.favoriteMascotId),
          );

          expect(
            bloc.state.favoriteMascotIdStreamOption.getOrFailTest(),
            emits(context.data.settings.favoriteMascotId),
          );
        },
      );

      blocTest(
        'should update individual settings when the value is different',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        verify: (bloc) {
          settingsSubject.add(
            context.data.settings.copyWith(
                favoriteMascotId: 2, talkingThreshold: const DecibelLufs(2)),
          );
          expect(
            bloc.state.favoriteMascotIdStreamOption.getOrFailTest(),
            emitsInOrder([context.data.settings.favoriteMascotId, 2]),
          );
          expect(
            bloc.state.talkingThresholdStreamOption.getOrFailTest(),
            emitsInOrder([
              context.data.settings.talkingThreshold,
              const DecibelLufs(2),
            ]),
          );
        },
      );

      blocTest<SettingsBloc, SettingsState>(
        'should reuse existing stream for individual settings',
        build: () => bloc,
        seed: () => SettingsLoaded(
            some(favoriteMascotIdSubject), some(talkingThresholdSubject)),
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        verify: (bloc) => {
          expect(
            bloc.state.favoriteMascotIdStreamOption.getOrFailTest(),
            favoriteMascotIdSubject,
          ),
          expect(
            bloc.state.talkingThresholdStreamOption.getOrFailTest(),
            talkingThresholdSubject,
          ),
        },
      );

      blocTest(
        'should emit [SettingError(${ErrorCodes.loadSettingsFailureCode})] when retrieval of settings fails',
        build: () => bloc,
        setUp: () => when(context.mocks.streamSettings(any))
            .thenAnswer((_) async => Left(LocalDataSourceFailure())),
        act: (bloc) => bloc.add(LoadSettingsEvent()),
        expect: () => [
          SettingsError(ErrorCodes.loadSettingsFailureCode, none(), none()),
        ],
      );
    });
  });
}
