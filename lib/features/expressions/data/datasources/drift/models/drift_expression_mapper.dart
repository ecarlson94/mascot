import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

import '../../../../domain/entities/expression.dart';
import 'drift_expression.dart';

part 'drift_expression_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class DriftExpressionMapper {
  DriftExpression fromExpression(Expression expression);
  Expression toExpression(DriftExpression driftExpression);
}
