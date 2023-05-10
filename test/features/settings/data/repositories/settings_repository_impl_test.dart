import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsRepositoryImpl repository;

  SettingsModel getSettingsModel() =>
      context.data.settingsMapper.fromSettings(context.data.settings);

  setUp(() {
    context = TestContext();
    repository = SettingsRepositoryImpl(
      context.mocks.settingsLocalDataSource,
      context.data.settingsMapper,
    );

    when(context.mocks.settingsLocalDataSource.getObject(1))
        .thenAnswer((_) => Single.value(getSettingsModel()));
    when(context.mocks.settingsLocalDataSource.putObject(any))
        .thenAnswer((_) => Single.value(1));
  });

  group('SettingsRepositoryImpl', () {
    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) => Single.value(getSettingsModel()));

        // act
        final result = await repository.loadSettings().single;

        // assert
        expect(
          result,
          context.data.settingsMapper.toSettings(getSettingsModel()),
        );
        verify(context.mocks.settingsLocalDataSource.getObject(1));
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });
    });

    group('setFavoriteMascotId', () {
      test('should update favoriteMascotId in local database', () async {
        // act
        final result = await repository.setFavoriteMascotId(27).single;

        // assert
        expect(result, unit);
        verify(
          context.mocks.settingsLocalDataSource.putObject(
            context.data.settingsMapper.fromSettings(
              context.data.settings.copyWith(favoriteMascotId: 27),
            ),
          ),
        );
      });
    });

    group('setTalkingThreshold', () {
      test('should update talkingThresholdDecibels in local database',
          () async {
        // arrange
        const threshold = DecibelLufs(27);

        // act
        final result = await repository.setTalkingThreshold(threshold).single;

        // assert
        expect(result, unit);
        verify(
          context.mocks.settingsLocalDataSource.putObject(
            context.data.settingsMapper.fromSettings(
              context.data.settings.copyWith(talkingThreshold: threshold),
            ),
          ),
        );
      });
    });
  });
}
