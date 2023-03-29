import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/drift/settings_drift_data_source.dart';
import '../models/settings_mapper.dart';

@Injectable(as: Logger<SettingsRepositoryImpl>)
class SettingsRepositoryLogger extends Logger<SettingsRepositoryImpl> {}

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDriftDataSource _localDataSource;
  final SettingsMapper _driftSettingsMapper;
  final Logger<SettingsRepositoryImpl> _logger;

  SettingsRepositoryImpl(
    this._localDataSource,
    this._driftSettingsMapper,
    this._logger,
  );

  @override
  FailureOrSettingsFuture loadSettings() async {
    try {
      var settingsModel = await _localDataSource.loadSettings();
      return Right(_driftSettingsMapper.toSettings(settingsModel));
    } catch (e) {
      _logger.logError('Failed to load settings', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrSettingsSubjectFuture streamSettings() async {
    try {
      var settingsModel = await _localDataSource.loadSettings();
      var settingsBehaviorSubject = BehaviorSubject<Settings>.seeded(
        _driftSettingsMapper.toSettings(settingsModel),
      );

      var settingsStream = _localDataSource.streamSettings();
      settingsStream.listen((event) async {
        settingsBehaviorSubject.add(
          _driftSettingsMapper.toSettings(event ?? settingsModel),
        );
      });

      return Right(settingsBehaviorSubject);
    } catch (e) {
      _logger.logError('Failed to stream settings', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setFavoriteMascotId(Id id) async {
    try {
      var settings = await _localDataSource.loadSettings();
      var updatedSettings = settings.copyWith(favoriteMascotId: id);

      return Right(
        await _localDataSource.saveSettings(updatedSettings),
      );
    } catch (e) {
      _logger.logError('Failed to set favorite mascot id', e);
      return Left(LocalDataSourceFailure());
    }
  }
}
