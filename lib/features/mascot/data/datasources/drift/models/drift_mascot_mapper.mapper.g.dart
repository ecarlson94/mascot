// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_mascot_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

@LazySingleton(as: DriftMascotMapper)
class DriftMascotMapperImpl extends DriftMascotMapper {
  DriftMascotMapperImpl() : super();

  @override
  DriftMascot fromMascot(Mascot mascot) {
    final driftmascot = DriftMascot(
      id: mascot.id,
      name: mascot.name,
      expressions: mascot.expressions.map((x) => fromExpression(x)).toSet(),
    );
    return driftmascot;
  }

  @override
  Mascot toMascot(DriftMascot driftMascot) {
    final mascot = Mascot(
      id: driftMascot.id,
      name: driftMascot.name,
      expressions: driftMascot.expressions.map((e) => toExpression(e)).toSet(),
    );
    return mascot;
  }

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
