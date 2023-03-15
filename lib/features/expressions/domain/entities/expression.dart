import 'package:drift/drift.dart';

import '../../../../core/clean_architecture/entity.dart';

class Expression extends Entity {
  final String name;
  final String description;
  final Uint8List image;

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
    Uint8List? image,
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
    image: Uint8List(0),
  );
}
