import 'package:injectable/injectable.dart';

import '../../../../domain/entities/settings.dart';
import '../../../models/map_settings_to_settings_model.dart';
import 'drift_settings.dart' hide Settings;

@injectable
class MapSettingsToDriftSettings extends MapSettingsToSettingsModel {
  @override
  DriftSettings map(Settings input) => DriftSettings(
        favoriteMascotId: input.favoriteMascotId,
      );
}
