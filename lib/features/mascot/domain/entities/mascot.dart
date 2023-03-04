import '../../../../core/clean_architecture/entity.dart';
import 'expression.dart';

class Mascot extends EquatableEntity {
  final String name;
  final List<Expression> expressions;

  const Mascot({
    required super.id,
    required this.name,
    this.expressions = const [],
  });

  @override
  List<Object?> get props => [id, name, expressions];
}
