import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/map_settings_to_settings_model.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource _localDataSource;
  final MapSettingsToSettingsModel _mapSettingsToSettingsModel;

  SettingsRepositoryImpl(
      this._localDataSource, this._mapSettingsToSettingsModel);

  @override
  FailureOrSettingsFuture loadSettings() async {
    try {
      return Right(await _localDataSource.loadSettings());
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrSettingsStreamFuture streamSettings() async {
    try {
      var settings = await _localDataSource.loadSettings();
      var settingsBehaviorSubject = BehaviorSubject<Settings>.seeded(
        await _mapSettingsToSettingsModel.reverse(settings),
      );

      var settingsStream = await _localDataSource.streamSettings();
      settingsStream.listen((event) async {
        settingsBehaviorSubject.add(
          await _mapSettingsToSettingsModel.reverse(event ?? settings),
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

      return Right(await _localDataSource.saveSettings(
        await _mapSettingsToSettingsModel(updatedSettings),
      ));
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }
}
