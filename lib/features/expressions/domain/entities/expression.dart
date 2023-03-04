import '../../../../core/clean_architecture/entity.dart';
import 'image.dart';

class Expression extends EquatableEntity {
  final String name;
  final String description;
  final Image image;

  const Expression({
    required super.id,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, description, image];

  Expression copyWith({
    Id? id,
    String? name,
    String? description,
    Image? image,
  }) {
    return Expression(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  static Expression empty = Expression(
    id: 0,
    name: '',
    description: '',
    image: Image.empty,
  );
}
