import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/drift/drift_database.dart';
import '../../../../expressions/data/datasources/drift/expressions_drift_data_source.dart';
import '../../../../expressions/data/datasources/drift/models/drift_expression.dart';
import 'models/drift_mascot.dart';

abstract class MascotsDriftDataSource {
  /// Saves a mascot to the local database.
  Future<Id> addMascot(DriftMascot mascot);

  /// Gets a mascot from the local database.
  Future<DriftMascot> getMascot(Id id);

  // Stream a mascot from the local database.
  Future<Stream<DriftMascot?>> streamMascot(Id id);
}

@Injectable(as: MascotsDriftDataSource)
class MascotsDriftDataSourceImpl implements MascotsDriftDataSource {
  final DriftyDatabase _database;
  final ExpressionsDriftDataSource _expressions;

  MascotsDriftDataSourceImpl(this._database, this._expressions);

  @override
  Future<Id> addMascot(DriftMascot driftMascot) async {
    final mascotId = await _updateMascot(driftMascot);

    await _createExpressionsForMascot(driftMascot.expressions, mascotId);

    return mascotId;
  }

  @override
  Future<DriftMascot> getMascot(Id id) =>
      _getDriftMascotForMascot(() => _getMascot(id));

  @override
  Future<Stream<DriftMascot?>> streamMascot(Id id) async {
    final subject = BehaviorSubject<DriftMascot?>();

    // listen to stream of mascot
    final mascotStream = (_database.select(_database.mascots)
          ..where((m) => m.id.equals(id)))
        .watchSingle();
    mascotStream.listen(
      (mascot) async => subject.add(
        await _getDriftMascotForMascot(() => mascot),
      ),
    );

    // listen to stream of expressions
    final expressionsStream = _queryExpressionsForMascot(id).watch();
    expressionsStream.listen((e) async {
      final mascot = await _getMascot(id);
      subject.add(DriftMascot(
        id: mascot.id,
        name: mascot.name,
        expressions: e.toSet(),
      ));
    });

    return subject;
  }

  Future<Mascot> _getMascot(Id id) async {
    final mascot = await (_database.select(_database.mascots)
          ..where((m) => m.id.equals(id)))
        .getSingle();
    return mascot;
  }

  Future<DriftMascot> _getDriftMascotForMascot(
      FutureOr<Mascot> Function() getMascot) async {
    final mascot = await getMascot();
    final expressions = await _queryExpressionsForMascot(mascot.id).get();

    return DriftMascot(
      id: mascot.id,
      name: mascot.name,
      expressions: expressions.toSet(),
    );
  }

  Selectable<DriftExpression> _queryExpressionsForMascot(Id id) {
    final expressionsQuery = _database.select(_database.mascotExpressions)
      ..where((m) => m.mascotId.equals(id));
    final expressions = expressionsQuery.map((e) => DriftExpression(
          id: e.expressionId,
          name: e.name,
          description: e.description,
          image: e.image,
        ));
    return expressions;
  }

  Future<int> _updateMascot(DriftMascot driftMascot) async {
    final mascot = MascotsCompanion.insert(
      id: driftMascot.id == 0 ? const Value.absent() : Value(driftMascot.id),
      name: driftMascot.name,
    );
    var mascotId =
        await _database.into(_database.mascots).insertOnConflictUpdate(mascot);
    return mascotId;
  }

  Future<void> _createExpressionsForMascot(
    Iterable<DriftExpression> expressions,
    int mascotId,
  ) async {
    for (var expression in expressions) {
      var id = await _expressions.upsertExpression(expression);
      await _database.into(_database.mascotExpressionMaps).insert(
            MascotExpressionMapsCompanion.insert(
              mascotId: mascotId,
              expressionId: id,
            ),
          );
    }
  }
}
