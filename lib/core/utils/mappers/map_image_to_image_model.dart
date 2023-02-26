import 'package:injectable/injectable.dart';

import '../../../features/images/data/models/image_model.dart';
import '../../../features/images/domain/entities/image.dart';
import 'mapper.dart';

@singleton
class MapImageToImageModel extends Mapper<Image, ImageModel> {
  @override
  ImageModel call(Image input) {
    return ImageModel(
      id: input.id,
      name: input.name,
    );
  }
}
