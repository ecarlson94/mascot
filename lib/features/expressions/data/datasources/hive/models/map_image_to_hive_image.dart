import 'package:injectable/injectable.dart';

import '../../../../domain/entities/image.dart';
import '../../../models/map_image_to_image_model.dart';
import 'hive_image.dart';

@injectable
class MapImageToHiveImage extends MapImageToImageModel {
  @override
  HiveImage map(Image input) => HiveImage(
        name: input.name,
        data: input.data,
      );
}
