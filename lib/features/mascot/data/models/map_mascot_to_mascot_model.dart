import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../../expressions/data/models/expression_model.dart';
import '../../../expressions/data/models/map_expression_to_expression_model.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

@injectable
class MapMascotToMascotModel extends Mapper<Mascot, MascotModel> {
  final MapExpressionToExpressionModel _mapExpressionToExpressionModel;

  MapMascotToMascotModel(this._mapExpressionToExpressionModel);

  @override
  FutureOr<MascotModel> call(Mascot input) {
    var expressionModels = input.expressions
        .map<ExpressionModel>(_mapExpressionToExpressionModel)
        .toSet();

    return MascotModel(
      id: input.id,
      name: input.name,
      expressions: expressionModels,
    );
  }

  @override
  FutureOr<Mascot> reverse(MascotModel input) => Mascot(
        id: input.id,
        name: input.name,
        expressions: input.expressions
            .map<Expression>(_mapExpressionToExpressionModel.reverse)
            .toSet(),
      );
}
