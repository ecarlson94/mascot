import '../../../../core/data/mapper.dart';
import '../../domain/entities/settings.dart';
import 'settings_model.dart';

abstract class MapSettingsToSettingsModel
    extends Mapper<Settings, SettingsModel> {
  @override
  Settings reverse(SettingsModel input) => Settings(
        favoriteMascotId: input.favoriteMascotId,
      );
}
