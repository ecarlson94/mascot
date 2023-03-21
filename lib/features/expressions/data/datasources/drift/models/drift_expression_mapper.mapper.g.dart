// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_expression_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

@LazySingleton(as: DriftExpressionMapper)
class DriftExpressionMapperImpl extends DriftExpressionMapper {
  DriftExpressionMapperImpl() : super();

  @override
  DriftExpression fromExpression(Expression expression) {
    final driftexpression = DriftExpression(
      id: expression.id,
      name: expression.name,
      description: expression.description,
      image: expression.image,
    );
    return driftexpression;
  }

  @override
  Expression toExpression(DriftExpression driftExpression) {
    final expression = Expression(
      id: driftExpression.id,
      name: driftExpression.name,
      description: driftExpression.description,
      image: driftExpression.image,
    );
    return expression;
  }
}
