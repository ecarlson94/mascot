import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

import '../../../../../expressions/data/datasources/drift/models/drift_expression.dart';
import '../../../../../expressions/domain/entities/expression.dart';
import '../../../../domain/entities/mascot.dart';
import 'drift_mascot.dart';

part 'drift_mascot_mapper.mapper.g.dart';

@Mapper(caseSensitiveFields: true, useInjection: true)
abstract class DriftMascotMapper {
  DriftMascot fromMascot(Mascot mascot);
  Mascot toMascot(DriftMascot driftMascot);

  DriftExpression fromExpression(Expression expression);
  Expression toExpression(DriftExpression driftExpression);
}
