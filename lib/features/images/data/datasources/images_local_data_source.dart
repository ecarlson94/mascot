import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../models/image_model.dart';

abstract class ImagesLocalDataSource {
  /// Saves an image to the local database.
  Future<ImageModel> saveImage(ImageModel image);

  /// Gets an image from the local database.
  Future<ImageModel> getImage(Id id);
}

@LazySingleton(as: ImagesLocalDataSource)
class ImagesIsarDataSource implements ImagesLocalDataSource {
  final IsarCollection<ImageModel> images;

  ImagesIsarDataSource(this.images);

  @override
  Future<ImageModel> getImage(Id id) async {
    var image = await images.get(id);
    if (image == null) throw Exception('Image not found');
    return image;
  }

  @override
  Future<ImageModel> saveImage(ImageModel image) async {
    var newImageId = await images.put(image);
    return getImage(newImageId);
  }
}
