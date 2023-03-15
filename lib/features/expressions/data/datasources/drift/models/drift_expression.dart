import 'package:drift/drift.dart';

import '../../../models/expression_model.dart';

class DriftExpression extends ExpressionModel {
  const DriftExpression({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
  });
}

@UseRowClass(DriftExpression)
class Expressions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  BlobColumn get image => blob()();
}
