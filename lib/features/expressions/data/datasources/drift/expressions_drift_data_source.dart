import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/drift/mascot_database.dart';
import 'models/drift_expression.dart';

abstract class ExpressionsDriftDataSource {
  /// Saves an expression to the local database.
  Future<Id> upsertExpression(DriftExpression expression);

  /// Saves several expressions to the local database.
  Future<List<Id>> upsertExpressions(Iterable<DriftExpression> expressions);

  /// Removes an expression from the local database.
  Future<void> removeExpression(Id id);

  /// Gets several expressions from the local database.
  Future<List<DriftExpression>> getExpressions(Iterable<Id> ids);

  /// Streams several expressions from the local database.
  Stream<List<DriftExpression>> streamExpressions(Iterable<Id> ids);
}

@Injectable(as: ExpressionsDriftDataSource)
class ExpressionsDriftDataSourceImpl implements ExpressionsDriftDataSource {
  final MascotDatabase _database;

  ExpressionsDriftDataSourceImpl(this._database);

  @override
  Future<Id> upsertExpression(DriftExpression expression) async {
    var expressionId = await _database
        .into(_database.expressions)
        .insertOnConflictUpdate(expression);

    return expression.id == 0 ? expressionId : expression.id;
  }

  @override
  Future<List<Id>> upsertExpressions(
      Iterable<DriftExpression> expressions) async {
    final ids = List<Id>.empty(growable: true);
    for (final expression in expressions) {
      var id = await _database
          .into(_database.expressions)
          .insertOnConflictUpdate(expression);
      ids.add(expression.id == 0 ? id : expression.id);
    }

    return ids;
  }

  @override
  Future<List<DriftExpression>> getExpressions(Iterable<Id> ids) =>
      (_database.select(_database.expressions)..where((e) => e.id.isIn(ids)))
          .get();

  @override
  Future<void> removeExpression(Id id) async {
    await (_database.delete(_database.mascotExpressionMaps)
          ..where((e) => e.expressionId.equals(id)))
        .go();
    await (_database.delete(_database.expressions)
          ..where((e) => e.id.equals(id)))
        .go();
  }

  @override
  Stream<List<DriftExpression>> streamExpressions(Iterable<Id> ids) =>
      (_database.select(_database.expressions)..where((e) => e.id.isIn(ids)))
          .watch();
}
