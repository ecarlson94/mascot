import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';

import '../../../features/expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../features/mascot/data/datasources/drift/models/drift_mascot.dart';
import '../../../features/settings/data/datasources/drift/models/drift_settings.dart';
import 'connection/connection.dart' as impl;

part 'mascot_database.g.dart';

@singleton
@DriftDatabase(
  tables: [
    Mascots,
    MascotExpressionMaps,
    Expressions,
    Settings,
  ],
  views: [
    MascotExpressions,
  ],
)
class MascotDatabase extends _$MascotDatabase {
  MascotDatabase() : super(impl.connect());

  MascotDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
