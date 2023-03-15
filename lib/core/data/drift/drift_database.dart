import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../features/expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../features/mascot/data/datasources/drift/models/drift_mascot.dart';
import '../../../features/settings/data/datasources/drift/models/drift_settings.dart';
import 'connection/connection.dart' as impl;

part 'drift_database.g.dart';

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
class DriftyDatabase extends _$DriftyDatabase {
  DriftyDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}
