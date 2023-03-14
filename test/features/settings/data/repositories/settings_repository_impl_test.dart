import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/map_settings_to_hive_settings.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SettingsRepositoryImpl repository;
  late MapSettingsToHiveSettings mapSettingsToSettingsModel;

  setUp(() {
    context = TestContext();
    mapSettingsToSettingsModel = MapSettingsToHiveSettings();
    repository = SettingsRepositoryImpl(
      context.mocks.settingsHiveDataSource,
      mapSettingsToSettingsModel,
    );
  });

  group('SettingsRepositoryImpl', () {
    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // arrange
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenAnswer((_) async => context.data.hiveSettings);

        // act
        final result = await repository.loadSettings();

        // assert
        expect(
          result.getOrElse(() => Settings.empty()),
          context.data.hiveSettings,
        );
        verify(context.mocks.settingsHiveDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsHiveDataSource);
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenThrow(Exception());

        // act
        final result = await repository.loadSettings();

        // assert
        expect(result, isA<Left<Failure, Settings>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsHiveDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsHiveDataSource);
      });
    });

    group('setFavoriteMascotId', () {
      test('should update favoriteMascotId in local database', () async {
        // arrange
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenAnswer((_) async => context.data.hiveSettings);
        when(context.mocks.settingsHiveDataSource.saveSettings(any))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.setFavoriteMascotId(27);

        // assert
        expect(result, isA<Right<Failure, Unit>>());
        verify(
          context.mocks.settingsHiveDataSource.saveSettings(
            mapSettingsToSettingsModel.map(
              context.data.hiveSettings.copyWith(favoriteMascotId: 27),
            ),
          ),
        );
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenAnswer((_) async => context.data.hiveSettings);
        when(context.mocks.settingsHiveDataSource.saveSettings(any))
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
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenAnswer((_) async => context.data.hiveSettings);
        when(context.mocks.settingsHiveDataSource.streamSettings())
            .thenAnswer((_) async => modelStream);

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Right<Failure, Stream<Settings?>>>());
        expect(
          result.getOrElse(() => BehaviorSubject()),
          emitsInOrder([
            mapSettingsToSettingsModel.reverse(context.data.hiveSettings),
          ]),
        );
        verify(context.mocks.settingsHiveDataSource.loadSettings());
        verify(context.mocks.settingsHiveDataSource.streamSettings());
        verifyNoMoreInteractions(context.mocks.settingsHiveDataSource);
      });

      test(
        'should convert Stream<SettingsModel> to Stream<Settings>',
        () async {
          // arrange
          var modelStream = BehaviorSubject<SettingsModel>();
          when(context.mocks.settingsHiveDataSource.loadSettings())
              .thenAnswer((_) async => context.data.hiveSettings);
          when(context.mocks.settingsHiveDataSource.streamSettings())
              .thenAnswer((_) async => modelStream);
          var updatedSettings = context.data.hiveSettings.copyWith(
            favoriteMascotId: 27,
          );
          var updatedSettingsModel =
              mapSettingsToSettingsModel.map(updatedSettings);

          // act
          final result = await repository.streamSettings();
          modelStream.add(updatedSettingsModel);

          // assert
          expect(result, isA<Right<Failure, Stream<Settings?>>>());
          expect(
            result.getOrElse(() => BehaviorSubject()),
            emitsInOrder([
              mapSettingsToSettingsModel.reverse(context.data.hiveSettings),
              updatedSettings,
            ]),
          );
        },
      );

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsHiveDataSource.loadSettings())
            .thenThrow(Exception());

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Left<Failure, Stream<Settings?>>>());
        expect(
          result.swap().getOrElse(() => InvalidInputFailure()),
          isA<LocalDataSourceFailure>(),
        );
        verify(context.mocks.settingsHiveDataSource.loadSettings());
        verifyNoMoreInteractions(context.mocks.settingsHiveDataSource);
      });
    });
  });
}
