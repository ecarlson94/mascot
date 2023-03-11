import '../../../expressions/data/models/expression_model.dart';
import '../../domain/entities/mascot.dart';

abstract class MascotModel extends Mascot {
  const MascotModel({
    required super.id,
    required super.name,
    required this.expressionModels,
  }) : super(expressions: const {});

  final Iterable<ExpressionModel> expressionModels;
  @override
  Set<ExpressionModel> get expressions;
}
