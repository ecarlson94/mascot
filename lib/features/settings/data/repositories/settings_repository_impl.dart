import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/utils/logger.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
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
  SettingsSingle loadSettings() =>
      _localDataSource.getObject(1).map(_settingsMapper.toSettings);

  @override
  SettingsStream streamSettings() =>
      _localDataSource.streamObject(1).map(_settingsMapper.toSettings);

  @override
  UnitSingle setFavoriteMascotId(Id id) => _localDataSource
      .getObject(1)
      .map((settings) => settings.copyWith(favoriteMascotId: id))
      .switchMapSingle(_localDataSource.putObject)
      .map((_) => unit);

  @override
  UnitSingle setTalkingThreshold(DecibelLufs threshold) => _localDataSource
      .getObject(1)
      .map((settings) =>
          settings.copyWith(talkingThresholdDecibels: threshold.value))
      .switchMapSingle(_localDataSource.putObject)
      .map((_) => unit);
}
