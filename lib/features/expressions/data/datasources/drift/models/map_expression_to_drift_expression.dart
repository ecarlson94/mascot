import 'package:injectable/injectable.dart';

import '../../../../domain/entities/expression.dart';
import '../../../models/map_expression_to_expression_model.dart';
import 'drift_expression.dart';

@injectable
class MapExpressionToDriftExpression extends MapExpressionToExpressionModel {
  @override
  DriftExpression map(Expression input) => DriftExpression(
        id: input.id,
        name: input.name,
        description: input.description,
        image: input.image,
      );
}
