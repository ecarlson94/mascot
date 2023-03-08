// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../domain/entities/settings.dart';

part 'settings_model.g.dart';

// ignore: todo
// TODO: uncomment when enabling Isar
// @Collection(
//   ignore: {'props', 'stringify'},
//   inheritance: false,
// )
@HiveType(typeId: 3)
class SettingsModel extends Settings {
  const SettingsModel({
    this.id = 1,
    this.favoriteMascotId = 0,
  }) : super(
          favoriteMascotId: favoriteMascotId,
        );

  @HiveField(0)
  @override
  final Id id;

  @HiveField(1)
  @override
  final Id favoriteMascotId;

  @override
  SettingsModel copyWithId(Id id) {
    return SettingsModel(
      id: id,
      favoriteMascotId: favoriteMascotId,
    );
  }
}
