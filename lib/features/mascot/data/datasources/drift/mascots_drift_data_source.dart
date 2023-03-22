import 'dart:async';

import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/drift/mascot_database.dart';
import '../../../../expressions/data/datasources/drift/expressions_drift_data_source.dart';
import '../../../../expressions/data/datasources/drift/models/drift_expression.dart';
import 'models/drift_mascot.dart';

abstract class MascotsDriftDataSource {
  /// Saves a mascot to the local database.
  Future<Id> addMascot(DriftMascot mascot);

  /// Gets a mascot from the local database.
  Future<DriftMascot> getMascot(Id id);

  // Stream a mascot rom the local database.
  Stream<DriftMascot?> streamMascot(Id id);
}

@LazySingleton(as: MascotsDriftDataSource)
class MascotsDriftDataSourceImpl implements MascotsDriftDataSource, Disposable {
  final MascotDatabase _database;
  final ExpressionsDriftDataSource _expressions;
  final List<StreamSubscription> _subscriptions = List.empty(growable: true);

  MascotsDriftDataSourceImpl(this._database, this._expressions);

  @override
  Future<Id> addMascot(DriftMascot driftMascot) async {
    var mascotId = await _database
        .into(_database.mascots)
        .insertOnConflictUpdate(driftMascot);

    await _createExpressionsForMascot(driftMascot.expressions, mascotId);

    return driftMascot.id == 0 ? mascotId : driftMascot.id;
  }

  @override
  Future<DriftMascot> getMascot(Id id) =>
      _getDriftMascotForMascot(() => _getMascot(id));

  @override
  Stream<DriftMascot?> streamMascot(Id id) {
    final subject = BehaviorSubject<DriftMascot?>();

    // listen to stream of mascot
    final mascotStream = (_database.select(_database.mascots)
          ..where((m) => m.id.equals(id)))
        .watchSingle();
    var mascotSub = mascotStream.listen(
      (mascot) async => subject.add(
        await _getDriftMascotForMascot(() => mascot),
      ),
    );

    // listen to stream of expressions
    final expressionsStream = _queryExpressionsForMascot(id).watch();
    var expressionSub = expressionsStream.listen((e) async {
      final mascot = await _getMascot(id);
      subject.add(DriftMascot(
        id: mascot.id,
        name: mascot.name,
        expressions: e.toSet(),
      ));
    });

    _subscriptions.addAll([mascotSub, expressionSub]);

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

  Future<void> _createExpressionsForMascot(
    Iterable<DriftExpression> expressions,
    int mascotId,
  ) async {
    var ids = await _expressions.upsertExpressions(expressions);

    var savedMascotExpressionMaps =
        await (_database.select(_database.mascotExpressionMaps)
              ..where((m) => m.expressionId.isIn(ids)))
            .get();
    var unsavedExpressionIds = ids.where(
        (id) => !savedMascotExpressionMaps.any((m) => m.expressionId == id));

    await _database.batch(
      (batch) async => batch.insertAllOnConflictUpdate(
        _database.mascotExpressionMaps,
        unsavedExpressionIds.map(
          (id) => MascotExpressionMapsCompanion.insert(
            mascotId: mascotId,
            expressionId: id,
          ),
        ),
      ),
    );
  }

  @override
  FutureOr onDispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }
}
