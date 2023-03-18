import 'package:injectable/injectable.dart';

import '../../../../../expressions/data/datasources/drift/models/map_expression_to_drift_expression.dart';
import '../../../../domain/entities/mascot.dart';
import '../../../models/map_mascot_to_mascot_model.dart';
import 'drift_mascot.dart';

@injectable
class MapMascotToDriftMascot extends MapMascotToMascotModel {
  final MapExpressionToDriftExpression mapExpressionToDriftExpression;

  MapMascotToDriftMascot(this.mapExpressionToDriftExpression)
      : super(mapExpressionToDriftExpression);

  @override
  DriftMascot map(Mascot input) => DriftMascot(
        id: input.id,
        name: input.name,
        expressions:
            input.expressions.map(mapExpressionToDriftExpression.map).toSet(),
      );
}
