import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/expression.dart';
import '../models/expression_model.dart';

@injectable
class MapExpressionToExpressionModel
    extends Mapper<Expression, ExpressionModel> {
  @override
  ExpressionModel call(Expression input) {
    return ExpressionModel(
      name: input.name,
      description: input.description,
      image: input.image,
    );
  }
}
