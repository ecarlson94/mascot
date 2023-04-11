import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsRepositoryImpl repository;

  setUp(() {
    context = TestContext();
    repository = SettingsRepositoryImpl(
      context.mocks.settingsLocalDataSource,
      context.data.settingsMapper,
      context.mocks.getLogger(),
    );
  });

  SettingsModel getSettingsModel() =>
      context.data.settingsMapper.fromSettings(context.data.settings);

  group('SettingsRepositoryImpl', () {
    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());

        // act
        final result = await repository.loadSettings();

        // assert
        expect(
          result.getOrElse(() => Settings.empty),
          context.data.settingsMapper.toSettings(getSettingsModel()),
        );
        verify(context.mocks.settingsLocalDataSource.getObject(1));
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenThrow(Exception());

        // act
        final result = await repository.loadSettings();

        // assert
        expect(result, isA<Left<Failure, Settings>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsLocalDataSource.getObject(1));
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });
    });

    group('setFavoriteMascotId', () {
      test('should update favoriteMascotId in local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.putObject(any))
            .thenAnswer((_) async => 1);

        // act
        final result = await repository.setFavoriteMascotId(27);

        // assert
        expect(result, isA<Right<Failure, Unit>>());
        verify(
          context.mocks.settingsLocalDataSource.putObject(
            context.data.settingsMapper.fromSettings(
              context.data.settings.copyWith(favoriteMascotId: 27),
            ),
          ),
        );
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.putObject(any))
            .thenThrow(Exception());

        // act
        final result = await repository.setFavoriteMascotId(27);

        // assert
        expect(result, isA<Left<Failure, Unit>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
      });
    });

    group('setTalkingThreshold', () {
      test('should update talkingThresholdDecibels in local database',
          () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.putObject(any))
            .thenAnswer((_) async => 1);
        const threshold = DecibelLufs(27);

        // act
        final result = await repository.setTalkingThreshold(threshold);

        // assert
        expect(result, isA<Right<Failure, Unit>>());
        verify(
          context.mocks.settingsLocalDataSource.putObject(
            context.data.settingsMapper.fromSettings(
              context.data.settings.copyWith(talkingThreshold: threshold),
            ),
          ),
        );
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.putObject(any))
            .thenThrow(Exception());
        const threshold = DecibelLufs(27);

        // act
        final result = await repository.setTalkingThreshold(threshold);

        // assert
        expect(result, isA<Left<Failure, Unit>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
      });
    });

    group('streamSettings', () {
      test('should seed the stream with the current settings', () async {
        // arrange
        var modelStream = BehaviorSubject<SettingsModel>();
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.streamObject(1))
            .thenAnswer((_) => modelStream);

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Right<Failure, Stream<Settings?>>>());
        expect(
          result.getOrElse(() => BehaviorSubject()),
          emitsInOrder([
            context.data.settingsMapper.toSettings(getSettingsModel()),
          ]),
        );
        verify(context.mocks.settingsLocalDataSource.getObject(1));
        verify(context.mocks.settingsLocalDataSource.streamObject(1));
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });

      test(
        'should convert Stream<SettingsModel> to Stream<Settings>',
        () async {
          // arrange
          var modelStream = BehaviorSubject<SettingsModel>();
          var settingsModel = getSettingsModel();
          when(context.mocks.settingsLocalDataSource.getObject(1))
              .thenAnswer((_) async => settingsModel);
          when(context.mocks.settingsLocalDataSource.streamObject(1))
              .thenAnswer((_) => modelStream);
          var updatedSettingsModel =
              settingsModel.copyWith(favoriteMascotId: 27);

          // act
          final result = await repository.streamSettings();
          modelStream.add(updatedSettingsModel);

          // assert
          expect(result, isA<Right<Failure, Stream<Settings?>>>());
          expect(
            result.getOrElse(() => BehaviorSubject()),
            emitsInOrder([
              context.data.settingsMapper.toSettings(getSettingsModel()),
              context.data.settingsMapper.toSettings(updatedSettingsModel),
            ]),
          );
        },
      );

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.getObject(1))
            .thenThrow(Exception());

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Left<Failure, Stream<Settings?>>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsLocalDataSource.getObject(1));
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });
    });
  });
}
