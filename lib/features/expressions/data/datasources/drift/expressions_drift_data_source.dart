import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/drift/drift_database.dart';
import 'models/drift_expression.dart';

abstract class ExpressionsDriftDataSource {
  ExpressionsDriftDataSource();

  /// Saves an expression to the local database.
  Future<Id> upsertExpression(DriftExpression expression);

  /// Removes an expression from the local database.
  Future<void> removeExpression(Id id);

  /// Gets several expressions from the local database.
  Future<List<DriftExpression>> getExpressions(List<Id> ids);

  /// Streams several expressions from the local database.
  Stream<List<DriftExpression>> streamExpressions(List<Id> ids);
}

@Injectable(as: ExpressionsDriftDataSource)
class ExpressionsDriftDataSourceImpl implements ExpressionsDriftDataSource {
  final DriftyDatabase _database;

  ExpressionsDriftDataSourceImpl(this._database);

  @override
  Future<Id> upsertExpression(DriftExpression expression) {
    var insertable = ExpressionsCompanion.insert(
      id: expression.id == 0 ? const Value.absent() : Value(expression.id),
      name: expression.name,
      description: expression.description,
      image: expression.image,
    );

    return _database
        .into(_database.expressions)
        .insertOnConflictUpdate(insertable);
  }

  @override
  Future<List<DriftExpression>> getExpressions(List<Id> ids) =>
      (_database.select(_database.expressions)..where((e) => e.id.isIn(ids)))
          .get();

  @override
  Future<void> removeExpression(Id id) =>
      (_database.delete(_database.expressions)..where((e) => e.id.equals(id)))
          .go();

  @override
  Stream<List<DriftExpression>> streamExpressions(List<Id> ids) =>
      (_database.select(_database.expressions)..where((e) => e.id.isIn(ids)))
          .watch();
}
