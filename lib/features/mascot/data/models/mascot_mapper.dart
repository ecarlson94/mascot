import 'package:injectable/injectable.dart';

import '../../../expressions/data/models/expression_mapper.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

abstract class MascotMapper {
  MascotModel fromMascot(Mascot mascot);
  Mascot toMascot(MascotModel driftMascot);
}

@LazySingleton(as: MascotMapper)
class MascotMapperImpl extends MascotMapper {
  final ExpressionMapper _expressionMapper;
  MascotMapperImpl(this._expressionMapper) : super();

  @override
  MascotModel fromMascot(Mascot mascot) {
    final driftmascot = MascotModel(
      id: mascot.id,
      name: mascot.name,
      expressions:
          mascot.expressions.map(_expressionMapper.fromExpression).toSet(),
    );
    return driftmascot;
  }

  @override
  Mascot toMascot(MascotModel driftMascot) {
    final mascot = Mascot(
      id: driftMascot.id,
      name: driftMascot.name,
      expressions:
          driftMascot.expressions.map(_expressionMapper.toExpression).toSet(),
    );
    return mascot;
  }
}
