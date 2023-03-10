import '../../../../core/clean_architecture/entity.dart';
import '../../../expressions/domain/entities/expression.dart';

class Mascot extends Entity<Mascot> {
  final String name;
  final Set<Expression> expressions;

  const Mascot({
    required super.id,
    required this.name,
    this.expressions = const {},
  });

  @override
  List<Object?> get props => [id, name, expressions];

  Mascot copyWith({
    Id? id,
    String? name,
    Set<Expression>? expressions,
  }) {
    return Mascot(
      id: id ?? this.id,
      name: name ?? this.name,
      expressions: expressions ?? this.expressions,
    );
  }

  static const Mascot empty = Mascot(
    id: 0,
    name: '',
    expressions: {},
  );
}
