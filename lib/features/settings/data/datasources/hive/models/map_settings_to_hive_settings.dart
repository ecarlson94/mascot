import 'package:injectable/injectable.dart';

import '../../../../domain/entities/settings.dart';
import '../../../models/map_settings_to_settings_model.dart';
import 'hive_settings.dart';

@injectable
class MapSettingsToHiveSettings extends MapSettingsToSettingsModel {
  @override
  HiveSettings map(Settings input) => HiveSettings(
        favoriteMascotId: input.favoriteMascotId,
      );
}
