import 'package:injectable/injectable.dart';

import '../../../expressions/data/models/expression_mapper.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

abstract class MascotMapper {
  MascotModel fromMascot(Mascot mascot);
  Mascot toMascot(MascotModel mascotModel);
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
  Mascot toMascot(MascotModel mascotModel) {
    final mascot = Mascot(
      id: mascotModel.id,
      name: mascotModel.name,
      expressions:
          mascotModel.expressions.map(_expressionMapper.toExpression).toSet(),
    );
    return mascot;
  }
}
