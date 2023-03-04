import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/mascot.dart';
import '../../../expressions/data/models/expression_model.dart';
import '../models/mascot_model.dart';
import '../../../expressions/data/repositories/map_expression_to_expression_model.dart';

@injectable
class MapMascotToMascotModel extends Mapper<Mascot, MascotModel> {
  final MapExpressionToExpressionModel _mapExpressionToExpressionModel;

  MapMascotToMascotModel(this._mapExpressionToExpressionModel);

  @override
  MascotModel call(Mascot input) {
    var expressionModels = input.expressions
        .map<ExpressionModel>(_mapExpressionToExpressionModel)
        .toList();

    return MascotModel(
      id: input.id,
      name: input.name,
      expressions: expressionModels,
    );
  }
}
