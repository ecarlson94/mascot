import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/drift_database.dart';
import '../../../models/settings_model.dart';

class DriftSettings extends SettingsModel implements Insertable<DriftSettings> {
  final int id = 1;

  const DriftSettings({required super.favoriteMascotId});

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) =>
      SettingsCompanion(
        id: Value(id),
        favoriteMascotId: Value(favoriteMascotId),
      ).toColumns(nullToAbsent);
}

@UseRowClass(DriftSettings)
class Settings extends Table {
  IntColumn get id => integer()();
  IntColumn get favoriteMascotId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
