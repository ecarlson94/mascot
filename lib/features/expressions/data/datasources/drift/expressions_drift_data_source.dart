import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/drift/mascot_database.dart';
import '../../models/expression_model.dart';
import 'models/drift_expression.dart';

abstract class ExpressionsDriftDataSource {
  /// Saves an expression to the local database.
  Future<Id> upsertExpression(ExpressionModel expression);

  /// Saves several expressions to the local database.
  Future<List<Id>> upsertExpressions(Iterable<ExpressionModel> expressions);

  /// Removes an expression from the local database.
  Future<void> removeExpression(Id id);

  /// Get an expression from the local databas.
  Future<ExpressionModel> getExpression(Id id);

  /// Gets several expressions from the local database.
  Future<List<ExpressionModel>> getExpressions(Iterable<Id> ids);

  /// Streams several expressions from the local database.
  Stream<List<ExpressionModel>> streamExpressions(Iterable<Id> ids);
}

@LazySingleton(as: ExpressionsDriftDataSource)
class ExpressionsDriftDataSourceImpl implements ExpressionsDriftDataSource {
  final MascotDatabase _database;

  ExpressionsDriftDataSourceImpl(this._database);

  @override
  Future<Id> upsertExpression(ExpressionModel expression) async {
    var expressionId = await _database
        .into(_database.expressions)
        .insertOnConflictUpdate(expression.toCompanion());

    return expression.id == 0 ? expressionId : expression.id;
  }

  @override
  Future<List<Id>> upsertExpressions(
      Iterable<ExpressionModel> expressions) async {
    final ids = List<Id>.empty(growable: true);
    for (final expression in expressions) {
      var id = await _database
          .into(_database.expressions)
          .insertOnConflictUpdate(expression.toCompanion());
      ids.add(expression.id == 0 ? id : expression.id);
    }

    return ids;
  }

  @override
  Future<ExpressionModel> getExpression(Id id) =>
      (_database.select(_database.expressions)..where((e) => e.id.equals(id)))
          .getSingle();

  @override
  Future<List<ExpressionModel>> getExpressions(Iterable<Id> ids) {
    if (ids.isEmpty) return Future.value(List.empty());

    return (_database.select(_database.expressions)
          ..where((e) => e.id.isIn(ids)))
        .get();
  }

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
  Stream<List<ExpressionModel>> streamExpressions(Iterable<Id> ids) =>
      (_database.select(_database.expressions)..where((e) => e.id.isIn(ids)))
          .watch();
}
