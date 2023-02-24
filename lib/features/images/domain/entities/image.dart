import '../../../../core/clean_architecture/entity.dart';

class Image extends Entity {
  final String name;

  const Image({super.id = 0, required this.name});

  @override
  List<Object?> get customProps => [name];
}
