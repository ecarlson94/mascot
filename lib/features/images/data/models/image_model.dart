import 'package:isar/isar.dart';

import '../../domain/entities/image.dart';

part 'image_model.g.dart'; // uncomment for isar

// uncomment for isar
@Collection(
  ignore: {'props', 'stringify'},
  inheritance: false,
)
class ImageModel implements Image {
  const ImageModel({this.id, required this.name});

  factory ImageModel.fromImage(Image image) => ImageModel(
        id: image.id,
        name: image.name,
      );

  @override
  final Id? id;

  @override
  final String name;

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => null;
}
