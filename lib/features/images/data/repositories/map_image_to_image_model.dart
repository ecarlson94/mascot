import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/image.dart';
import '../models/image_model.dart';

@injectable
class MapImageToImageModel extends Mapper<Image, ImageModel> {
  @override
  ImageModel call(Image input) {
    return ImageModel(
      id: input.id,
      name: input.name,
      data: input.data,
    );
  }
}
