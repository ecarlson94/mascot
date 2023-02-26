import '../../../../core/clean_architecture/entity.dart';

class Image extends EquatableEntity {
  final String name;

  const Image({super.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
