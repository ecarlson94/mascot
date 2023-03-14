import '../../../../core/data/mapper.dart';
import '../../domain/entities/image.dart';
import 'image_model.dart';

abstract class MapImageToImageModel extends Mapper<Image, ImageModel> {
  @override
  Image reverse(ImageModel input) => Image(data: input.data, name: input.name);
}
