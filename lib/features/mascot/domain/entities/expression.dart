import 'package:equatable/equatable.dart';

import '../../../images/domain/entities/image.dart';

class Expression extends Equatable {
  final String name;
  final String description;
  final Image image;

  const Expression({
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [name, description, image];
}
