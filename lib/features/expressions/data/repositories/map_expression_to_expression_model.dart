import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/expression.dart';
import '../models/expression_model.dart';
import 'map_image_to_image_model.dart';

@injectable
class MapExpressionToExpressionModel
    extends Mapper<Expression, ExpressionModel> {
  final MapImageToImageModel _mapImageToImageModel;

  MapExpressionToExpressionModel(this._mapImageToImageModel);

  @override
  ExpressionModel call(Expression input) {
    return ExpressionModel(
      id: input.id,
      name: input.name,
      description: input.description,
      image: _mapImageToImageModel(input.image),
    );
  }
}
