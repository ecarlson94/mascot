import '../../../../core/data/mapper.dart';
import '../../domain/entities/expression.dart';
import 'expression_model.dart';

abstract class MapExpressionToExpressionModel
    extends Mapper<Expression, ExpressionModel> {
  @override
  Expression reverse(ExpressionModel input) => Expression(
        id: input.id,
        name: input.name,
        description: input.description,
        image: input.image,
      );
}
