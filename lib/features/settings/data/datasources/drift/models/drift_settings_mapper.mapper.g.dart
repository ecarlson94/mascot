// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_settings_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

@LazySingleton(as: DriftSettingsMapper)
class DriftSettingsMapperImpl extends DriftSettingsMapper {
  DriftSettingsMapperImpl() : super();

  @override
  DriftSettings fromSettings(Settings settings) {
    final driftsettings =
        DriftSettings(favoriteMascotId: settings.favoriteMascotId);
    return driftsettings;
  }

  @override
  Settings toSettings(DriftSettings driftSettings) {
    final settings = Settings(favoriteMascotId: driftSettings.favoriteMascotId);
    return settings;
  }
}
