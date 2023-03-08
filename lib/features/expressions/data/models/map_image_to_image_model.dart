import 'package:injectable/injectable.dart';

import '../../../../core/data/mapper.dart';
import '../../domain/entities/image.dart';
import 'image_model.dart';

@injectable
class MapImageToImageModel extends Mapper<Image, ImageModel> {
  @override
  ImageModel call(Image input) => ImageModel(
        name: input.name,
        data: input.data,
      );

  @override
  Image reverse(ImageModel input) => Image(data: input.data, name: input.name);
}
