import 'package:drift/drift.dart';

import '../../../../../../core/data/drift/mascot_database.dart';
import '../../../models/expression_model.dart';

extension ExpressionModelExtension on ExpressionModel {
  ExpressionsCompanion toCompanion() => ExpressionsCompanion.insert(
        id: id == 0 ? const Value.absent() : Value(id),
        name: name,
        description: description,
        image: image,
      );
}

@UseRowClass(ExpressionModel)
class Expressions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  BlobColumn get image => blob()();
}
