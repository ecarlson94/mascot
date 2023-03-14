// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../../../core/clean_architecture/entity.dart';
import '../../../../../../core/data/hive/hive_model.dart';
import '../../../models/settings_model.dart';

part 'hive_settings.g.dart';

@HiveType(typeId: 4)
class HiveSettings extends SettingsModel implements HiveModel<HiveSettings> {
  const HiveSettings({
    this.favoriteMascotId = 0,
  }) : super(favoriteMascotId: favoriteMascotId);

  @HiveField(0)
  @override
  final Id id = 1;

  @HiveField(1)
  @override
  final Id favoriteMascotId;

  @override
  HiveSettings copyWithId(Id id) {
    return HiveSettings(
      favoriteMascotId: favoriteMascotId,
    );
  }
}
