// ignore_for_file: overridden_fields

import '../../../expressions/data/models/expression_model.dart';
import '../../domain/entities/mascot.dart';

class MascotModel extends Mascot {
  const MascotModel({
    required super.id,
    required super.name,
    required this.expressions,
  });

  @override
  final Set<ExpressionModel> expressions;
}
