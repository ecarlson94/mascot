import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/drift/models/map_settings_to_drift_settings.dart';
import '../datasources/drift/settings_drift_data_source.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDriftDataSource _localDataSource;
  final MapSettingsToDriftSettings _mapSettingsToSettingsModel;

  SettingsRepositoryImpl(
      this._localDataSource, this._mapSettingsToSettingsModel);

  @override
  FailureOrSettingsFuture loadSettings() async {
    try {
      var settingsModel = await _localDataSource.loadSettings();
      return Right(_mapSettingsToSettingsModel.reverse(settingsModel));
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrSettingsSubjectFuture streamSettings() async {
    try {
      var settingsModel = await _localDataSource.loadSettings();
      var settingsBehaviorSubject = BehaviorSubject<Settings>.seeded(
        _mapSettingsToSettingsModel.reverse(settingsModel),
      );

      var settingsStream = _localDataSource.streamSettings();
      settingsStream.listen((event) async {
        settingsBehaviorSubject.add(
          _mapSettingsToSettingsModel.reverse(event ?? settingsModel),
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
          _mapSettingsToSettingsModel.map(updatedSettings),
        ),
      );
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }
}
