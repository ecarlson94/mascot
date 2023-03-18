import '../../../../core/data/mapper.dart';
import '../../../expressions/data/models/map_expression_to_expression_model.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

abstract class MapMascotToMascotModel extends Mapper<Mascot, MascotModel> {
  final MapExpressionToExpressionModel mapExpressionToExpressionModel;

  MapMascotToMascotModel(this.mapExpressionToExpressionModel);

  @override
  Mascot reverse(MascotModel input) => Mascot(
        id: input.id,
        name: input.name,
        expressions: input.expressions
            .map(mapExpressionToExpressionModel.reverse)
            .toSet(),
      );
}
