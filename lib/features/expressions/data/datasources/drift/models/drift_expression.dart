import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/mascot_database.dart';
import '../../../models/expression_model.dart';

class DriftExpression extends ExpressionModel
    implements Insertable<DriftExpression> {
  const DriftExpression({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
  });

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) =>
      ExpressionsCompanion.insert(
        id: id == 0 ? const Value.absent() : Value(id),
        name: name,
        description: description,
        image: image,
      ).toColumns(nullToAbsent);
}

@UseRowClass(DriftExpression)
class Expressions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  BlobColumn get image => blob()();
}
