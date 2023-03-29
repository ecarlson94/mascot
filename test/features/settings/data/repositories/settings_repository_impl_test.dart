import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings.dart'
    hide Settings;
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
      context.data.driftSettingsMapper,
      context.mocks.getLogger(),
    );
  });

  SettingsModel getSettingsModel() =>
      context.data.driftSettingsMapper.fromSettings(context.data.settings);

  group('SettingsRepositoryImpl', () {
    group('loadSettings', () {
      test('should return SettingsModel from local database', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => getSettingsModel());

        // act
        final result = await repository.loadSettings();

        // assert
        expect(
          result.getOrElse(() => Settings.empty),
          context.data.driftSettingsMapper.toSettings(getSettingsModel()),
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
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.saveSettings(any))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.setFavoriteMascotId(27);

        // assert
        expect(result, isA<Right<Failure, Unit>>());
        verify(
          context.mocks.settingsLocalDataSource.saveSettings(
            context.data.driftSettingsMapper.fromSettings(
              context.data.settings.copyWith(favoriteMascotId: 27),
            ),
          ),
        );
      });

      test('should return failure if local database throws', () async {
        // arrange
        when(context.mocks.settingsLocalDataSource.loadSettings())
            .thenAnswer((_) async => getSettingsModel());
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
            .thenAnswer((_) async => getSettingsModel());
        when(context.mocks.settingsLocalDataSource.streamSettings())
            .thenAnswer((_) => modelStream);

        // act
        final result = await repository.streamSettings();

        // assert
        expect(result, isA<Right<Failure, Stream<Settings?>>>());
        expect(
          result.getOrElse(() => BehaviorSubject()),
          emitsInOrder([
            context.data.driftSettingsMapper.toSettings(getSettingsModel()),
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
          var settingsModel = getSettingsModel();
          when(context.mocks.settingsLocalDataSource.loadSettings())
              .thenAnswer((_) async => settingsModel);
          when(context.mocks.settingsLocalDataSource.streamSettings())
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
              context.data.driftSettingsMapper.toSettings(getSettingsModel()),
              context.data.driftSettingsMapper.toSettings(updatedSettingsModel),
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
