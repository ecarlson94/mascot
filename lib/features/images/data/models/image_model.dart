import 'package:isar/isar.dart';

import '../../domain/entities/image.dart';

part 'image_model.g.dart';

@Collection(ignore: {'props', '_props', 'id'})
class ImageModel extends Image {
  @Name('id')
  final Id isarId;

  const ImageModel({required Id isarId})
      : isarId = isarId == 0 ? Isar.autoIncrement : isarId,
        super(id: isarId == 0 ? Isar.autoIncrement : isarId);

  factory ImageModel.fromImage(Image image) => ImageModel(isarId: image.id);
}
