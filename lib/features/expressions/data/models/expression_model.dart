import '../../domain/entities/expression.dart';

abstract class ExpressionModel extends Expression {
  const ExpressionModel({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
  });
}
