import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/settings/data/models/map_settings_to_settings_model.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsRepositoryImpl repository;
  late MapSettingsToSettingsModel mapSettingsToSettingsModel;

  setUp(() {
    context = TestContext();
    mapSettingsToSettingsModel = MapSettingsToSettingsModel();
    repository = SettingsRepositoryImpl(
      context.mocks.settingsLocalDataSource,
      mapSettingsToSettingsModel,
    );
  });

  group('SettingsRepositoryImpl', () {
    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => context.data.settingsModel);

        // act
        final result = await repository.loadSettings();

        // assert
        expect(
          result.getOrElse(() => const Settings()),
          context.data.settingsModel,
        );
        verify(context.mocks.settingsLocalDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenThrow(Exception());

        // act
        final result = await repository.loadSettings();

        // assert
        expect(result, isA<Left<Failure, Settings>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsLocalDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });
    });

    group('setFavoriteMascotId', () {
      test('should update favoriteMascotId in local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => context.data.settingsModel);
        when(context.mocks.settingsLocalDataSource.saveSettings(any))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.setFavoriteMascotId(27);

        // assert
        expect(result, isA<Right<Failure, Unit>>());
        verify(
          context.mocks.settingsLocalDataSource.saveSettings(
            await mapSettingsToSettingsModel(
              context.data.settingsModel.copyWith(favoriteMascotId: 27),
            ),
          ),
        );
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => context.data.settingsModel);
        when(context.mocks.settingsLocalDataSource.saveSettings(any))
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

    group('streamSettings', () {
      test('should seed the stream with the current settings', () async {
        // arrange
        var modelStream = BehaviorSubject<SettingsModel>();
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => context.data.settingsModel);
        when(context.mocks.settingsLocalDataSource.streamSettings())
            .thenAnswer((_) async => modelStream);

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Right<Failure, Stream<Settings?>>>());
        expect(
          result.getOrElse(() => const Stream.empty()),
          emitsInOrder([
            await mapSettingsToSettingsModel
                .reverse(context.data.settingsModel),
          ]),
        );
        verify(context.mocks.settingsLocalDataSource.loadSettings());
        verify(context.mocks.settingsLocalDataSource.streamSettings());
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });

      test(
        'should convert Stream<SettingsModel> to Stream<Settings>',
        () async {
          // arrange
          var modelStream = BehaviorSubject<SettingsModel>();
          when(context.mocks.settingsLocalDataSource.loadSettings())
              .thenAnswer((_) async => context.data.settingsModel);
          when(context.mocks.settingsLocalDataSource.streamSettings())
              .thenAnswer((_) async => modelStream);
          var updatedSettings = context.data.settingsModel.copyWith(
            favoriteMascotId: 27,
          );
          var updatedSettingsModel =
              await mapSettingsToSettingsModel(updatedSettings);

          // act
          final result = await repository.streamSettings();
          modelStream.add(updatedSettingsModel);

          // assert
          expect(result, isA<Right<Failure, Stream<Settings?>>>());
          expect(
            result.getOrElse(() => const Stream.empty()),
            emitsInOrder([
              await mapSettingsToSettingsModel
                  .reverse(context.data.settingsModel),
              updatedSettings,
            ]),
          );
        },
      );

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenThrow(Exception());

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Left<Failure, Stream<Settings?>>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsLocalDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsLocalDataSource);
      });
    });
  });
}
