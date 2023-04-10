import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/indexded_db/settings_indexed_db_data_source.dart';
import '../models/settings_mapper.dart';

@Injectable(as: Logger<SettingsRepositoryImpl>)
class SettingsRepositoryLogger extends Logger<SettingsRepositoryImpl> {}

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsIndexedDbDataSource _localDataSource;
  final SettingsMapper _settingsMapper;
  final Logger<SettingsRepositoryImpl> _logger;

  SettingsRepositoryImpl(
    this._localDataSource,
    this._settingsMapper,
    this._logger,
  );

  @override
  FailureOrSettingsFuture loadSettings() async {
    try {
      var settingsModel = await _localDataSource.getObject(1);
      return Right(_settingsMapper.toSettings(settingsModel));
    } catch (e) {
      _logger.logError('Failed to load settings', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrSettingsSubjectFuture streamSettings() async {
    try {
      var settingsModel = await _localDataSource.getObject(1);
      var settingsBehaviorSubject = BehaviorSubject<Settings>.seeded(
        _settingsMapper.toSettings(settingsModel),
      );

      var settingsStream = _localDataSource.streamObject(1);
      settingsStream.listen((event) async {
        settingsBehaviorSubject.add(
          _settingsMapper.toSettings(event),
        );
      });

      return Right(settingsBehaviorSubject);
    } catch (e) {
      _logger.logError('Failed to stream settings', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrUnitFuture setFavoriteMascotId(Id id) async {
    try {
      var settings = await _localDataSource.getObject(1);
      var updatedSettings = settings.copyWith(favoriteMascotId: id);
      await _localDataSource.putObject(updatedSettings);

      return const Right(unit);
    } catch (e) {
      _logger.logError('Failed to set favorite mascot id', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrUnitFuture setTalkingThreshold(DecibelLufs threshold) async {
    try {
      var settings = await _localDataSource.getObject(1);
      var updatedSettings = settings.copyWith(
        talkingThresholdDecibels: threshold.value,
      );
      await _localDataSource.putObject(updatedSettings);

      return const Right(unit);
    } catch (e) {
      _logger.logError('Failed to set talking threshold', e);
      return Left(LocalDataSourceFailure());
    }
  }
}
