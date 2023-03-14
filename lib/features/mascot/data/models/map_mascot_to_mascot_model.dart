import '../../../../core/data/mapper.dart';
import '../../../expressions/data/datasources/hive/models/map_expression_to_hive_expression.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

abstract class MapMascotToMascotModel extends Mapper<Mascot, MascotModel> {
  final MapExpressionToHiveExpression mapExpressionToHiveExpression;

  MapMascotToMascotModel(this.mapExpressionToHiveExpression);

  @override
  Mascot reverse(MascotModel input) => Mascot(
        id: input.id,
        name: input.name,
        expressions: input.expressions
            .map(mapExpressionToHiveExpression.reverse)
            .toSet(),
      );
}
