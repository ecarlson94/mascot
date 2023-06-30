import 'package:injectable/injectable.dart';

import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../domain/entities/settings.dart';
import 'record_settings_mapper.dart';
import 'settings_model.dart';

abstract class SettingsMapper {
  SettingsModel fromSettings(Settings settings);
  Settings toSettings(SettingsModel settingsModel);
}

@LazySingleton(as: SettingsMapper)
class SettingsMapperImpl implements SettingsMapper {
  final RecordSettingsMapper _recordSettingsMapper;

  SettingsMapperImpl(this._recordSettingsMapper);

  @override
  SettingsModel fromSettings(Settings settings) {
    return SettingsModel(
      id: 1,
      favoriteMascotId: settings.favoriteMascotId,
      talkingThresholdDecibels: settings.talkingThreshold.value,
      recordSettings:
          _recordSettingsMapper.fromRecordSettings(settings.recordSettings),
    );
  }

  @override
  Settings toSettings(SettingsModel settingsModel) {
    return Settings(
      favoriteMascotId: settingsModel.favoriteMascotId,
      talkingThreshold: DecibelLufs(settingsModel.talkingThresholdDecibels),
      recordSettings: _recordSettingsMapper.toRecordSettings(
        settingsModel.recordSettings,
      ),
    );
  }
}
