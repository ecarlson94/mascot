import '../../../expressions/data/models/expression_model.dart';
import '../../domain/entities/mascot.dart';

abstract class MascotModel extends Mascot {
  const MascotModel({
    required super.id,
    required super.name,
    required Set<ExpressionModel> expressions,
  })  : _expressionModels = expressions,
        super(expressions: expressions);

  final Set<ExpressionModel> _expressionModels;
  @override
  Set<ExpressionModel> get expressions => _expressionModels;
}
