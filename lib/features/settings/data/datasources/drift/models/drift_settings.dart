import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/mascot_database.dart';
import '../../../../../mascot/data/datasources/drift/models/drift_mascot.dart';
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

  @override
  DriftSettings copyWith({int? favoriteMascotId}) => DriftSettings(
      favoriteMascotId: favoriteMascotId ?? this.favoriteMascotId);

  static const DriftSettings empty = DriftSettings(favoriteMascotId: null);
}

@UseRowClass(DriftSettings)
class Settings extends Table {
  IntColumn get id => integer()();
  IntColumn get favoriteMascotId =>
      integer().nullable().references(Mascots, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
