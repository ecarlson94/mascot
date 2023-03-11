import 'package:injectable/injectable.dart';

import '../../../../domain/entities/expression.dart';
import '../../../models/map_expression_to_expression_model.dart';
import 'hive_expression.dart';

@injectable
class MapExpressionToHiveExpression extends MapExpressionToExpressionModel {
  MapExpressionToHiveExpression(super._mapImageToHiveImage);

  @override
  HiveExpression map(Expression input) => HiveExpression(
        id: input.id,
        name: input.name,
        description: input.description,
        imageModel: mapImageToHiveImage.map(input.image),
      );
}
