import 'package:injectable/injectable.dart';

import '../../domain/entities/expression.dart';
import 'expression_model.dart';

abstract class ExpressionMapper {
  ExpressionModel fromExpression(Expression expression);
  Expression toExpression(ExpressionModel expressionModel);
}

@LazySingleton(as: ExpressionMapper)
class ExpressionMapperImpl implements ExpressionMapper {
  @override
  ExpressionModel fromExpression(Expression expression) {
    return ExpressionModel(
      id: expression.id,
      name: expression.name,
      description: expression.description,
      image: expression.image,
      priority: expression.priority,
      activator: expression.activator,
    );
  }

  @override
  Expression toExpression(ExpressionModel expressionModel) {
    return Expression(
      id: expressionModel.id,
      name: expressionModel.name,
      description: expressionModel.description,
      image: expressionModel.image,
      priority: expressionModel.priority,
      activator: expressionModel.activator,
    );
  }
}
