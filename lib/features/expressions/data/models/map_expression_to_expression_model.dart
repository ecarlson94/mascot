import '../../../../core/data/mapper.dart';
import '../../domain/entities/expression.dart';
import '../datasources/hive/models/map_image_to_hive_image.dart';
import 'expression_model.dart';

abstract class MapExpressionToExpressionModel
    extends Mapper<Expression, ExpressionModel> {
  final MapImageToHiveImage mapImageToHiveImage;

  MapExpressionToExpressionModel(this.mapImageToHiveImage);

  @override
  Expression reverse(ExpressionModel input) => Expression(
        id: input.id,
        name: input.name,
        description: input.description,
        image: mapImageToHiveImage.reverse(input.image),
      );
}
