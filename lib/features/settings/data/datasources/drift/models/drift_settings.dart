import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/mascot_database.dart';
import '../../../../../mascot/data/datasources/drift/models/drift_mascot.dart';
import '../../../models/settings_model.dart';

extension DriftSettings on SettingsModel {
  SettingsCompanion toCompanion() => SettingsCompanion(
        id: Value(id),
        favoriteMascotId: Value(favoriteMascotId),
      );
}

@UseRowClass(SettingsModel)
class Settings extends Table {
  IntColumn get id => integer()();
  IntColumn get favoriteMascotId =>
      integer().nullable().references(Mascots, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
