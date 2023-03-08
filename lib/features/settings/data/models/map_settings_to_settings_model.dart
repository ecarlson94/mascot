import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/settings.dart';
import 'settings_model.dart';

@injectable
class MapSettingsToSettingsModel extends Mapper<Settings, SettingsModel> {
  @override
  FutureOr<SettingsModel> call(Settings input) => SettingsModel(
        id: input.id,
        favoriteMascotId: input.favoriteMascotId,
      );

  @override
  FutureOr<Settings> reverse(SettingsModel input) => Settings(
        id: input.id,
        favoriteMascotId: input.favoriteMascotId,
      );
}
