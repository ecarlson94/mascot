import 'package:injectable/injectable.dart';

import '../../../../../expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../../../expressions/domain/entities/expression.dart';
import '../../../../domain/entities/mascot.dart';
import 'drift_mascot.dart';

abstract class DriftMascotMapper {
  DriftMascot fromMascot(Mascot mascot);
  Mascot toMascot(DriftMascot driftMascot);

  DriftExpression fromExpression(Expression expression);
  Expression toExpression(DriftExpression driftExpression);
}

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
