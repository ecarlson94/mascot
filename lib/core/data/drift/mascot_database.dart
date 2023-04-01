import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../../features/expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../features/expressions/data/models/expression_model.dart';
import '../../../features/mascot/data/datasources/drift/models/drift_mascot.dart';
import '../../../features/settings/data/datasources/drift/models/drift_settings.dart';
import '../../../features/settings/data/models/settings_model.dart';
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
class MascotDatabase extends _$MascotDatabase implements Disposable {
  MascotDatabase() : super(impl.connect());

  MascotDatabase.memory() : super(impl.connect(isInMemory: true));

  @override
  int get schemaVersion => 1;

  @override
  void onDispose() {
    super.close();
  }
}
