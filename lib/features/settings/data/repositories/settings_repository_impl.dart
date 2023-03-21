import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/drift/models/drift_settings_mapper.dart';
import '../datasources/drift/settings_drift_data_source.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDriftDataSource _localDataSource;
  final DriftSettingsMapper _driftSettingsMapper;

  SettingsRepositoryImpl(
    this._localDataSource,
    this._driftSettingsMapper,
  );

  @override
  FailureOrSettingsFuture loadSettings() async {
    try {
      var settingsModel = await _localDataSource.loadSettings();
      return Right(_driftSettingsMapper.toSettings(settingsModel));
    } on Exception {
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
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setFavoriteMascotId(Id id) async {
    try {
      var settings = await _localDataSource.loadSettings();
      var updatedSettings = settings.copyWith(favoriteMascotId: id);

      return Right(
        await _localDataSource.saveSettings(
          _driftSettingsMapper.fromSettings(updatedSettings),
        ),
      );
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }
}
