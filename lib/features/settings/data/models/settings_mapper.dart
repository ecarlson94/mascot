import 'package:injectable/injectable.dart';

import '../../domain/entities/settings.dart';
import 'settings_model.dart';

abstract class SettingsMapper {
  SettingsModel fromSettings(Settings settings);
  Settings toSettings(SettingsModel driftSettings);
}

@LazySingleton(as: SettingsMapper)
class SettingsMapperImpl implements SettingsMapper {
  @override
  SettingsModel fromSettings(Settings settings) {
    return SettingsModel(
      id: 1,
      favoriteMascotId: settings.favoriteMascotId,
    );
  }

  @override
  Settings toSettings(SettingsModel settingsModel) {
    return Settings(
      favoriteMascotId: settingsModel.favoriteMascotId,
    );
  }
}