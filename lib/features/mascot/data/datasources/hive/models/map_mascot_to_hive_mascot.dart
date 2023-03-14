import 'package:injectable/injectable.dart';

import '../../../../../expressions/data/datasources/hive/models/hive_expression.dart';
import '../../../../domain/entities/mascot.dart';
import '../../../models/map_mascot_to_mascot_model.dart';
import 'hive_mascot.dart';

@injectable
class MapMascotToHiveMascot extends MapMascotToMascotModel {
  MapMascotToHiveMascot(super.mapExpressionToHiveExpression);

  @override
  HiveMascot map(Mascot input) => HiveMascot(
        id: input.id,
        name: input.name,
        expressionModels: input.expressions
            .map<HiveExpression>(mapExpressionToHiveExpression.map)
            .toList(),
      );
}
