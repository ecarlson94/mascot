import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/mascot_database.dart';
import '../../../../../expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../models/mascot_model.dart';

class DriftMascot extends MascotModel implements Insertable<Mascot> {
  const DriftMascot({
    required super.id,
    required super.name,
    required Set<DriftExpression> expressions,
  })  : _expressions = expressions,
        super(expressions: expressions);

  final Set<DriftExpression> _expressions;

  @override
  Set<DriftExpression> get expressions => _expressions;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) =>
      MascotsCompanion(
        id: id == 0 ? const Value.absent() : Value(id),
        name: Value(name),
      ).toColumns(nullToAbsent);
}

class Mascots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class MascotExpressionMaps extends Table {
  IntColumn get mascotId => integer()();
  IntColumn get expressionId => integer().unique()();

  @override
  Set<Column> get primaryKey => {mascotId, expressionId};
}

abstract class MascotExpressions extends View {
  // Abstract getters define the tables that this view uses
  MascotExpressionMaps get mascotExpressionMaps;
  Expressions get expressions;

  @override
  Query<HasResultSet, dynamic> as() => select([
        mascotExpressionMaps.mascotId,
        mascotExpressionMaps.expressionId,
        expressions.name,
        expressions.description,
        expressions.image,
      ]).from(mascotExpressionMaps).join([
        innerJoin(
          expressions,
          expressions.id.equalsExp(mascotExpressionMaps.expressionId),
        )
      ]);
}
