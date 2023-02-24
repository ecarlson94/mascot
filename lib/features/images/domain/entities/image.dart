import '../../../../core/clean_architecture/entity.dart';

class Image extends Entity {
  final String name;

  const Image({required super.id, required this.name});

  @override
  List<Object?> get customProps => [name];
}
