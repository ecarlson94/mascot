import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/expression.dart';
import 'expression_model.dart';
import 'map_image_to_image_model.dart';

@injectable
class MapExpressionToExpressionModel
    extends Mapper<Expression, ExpressionModel> {
  final MapImageToImageModel _mapImageToImageModel;

  MapExpressionToExpressionModel(this._mapImageToImageModel);

  @override
  ExpressionModel call(Expression input) => ExpressionModel(
        id: input.id,
        name: input.name,
        description: input.description,
        image: _mapImageToImageModel(input.image),
      );

  @override
  Expression reverse(ExpressionModel input) => Expression(
        id: input.id,
        name: input.name,
        description: input.description,
        image: _mapImageToImageModel.reverse(input.image),
      );
}
