import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../models/image_model.dart';
import 'images_collection.dart';

abstract class ImagesLocalDataSource {
  /// Saves an image to the local database.
  Future<ImageModel> saveImage(ImageModel image);

  /// Gets an image from the local database.
  Future<ImageModel> getImage(Id? id);
}

@LazySingleton(as: ImagesLocalDataSource)
class ImagesLocalDataSourceImpl implements ImagesLocalDataSource {
  final LocalImages collection;

  ImagesLocalDataSourceImpl(this.collection);

  @override
  Future<ImageModel> getImage(Id? id) => collection.get(id);

  @override
  Future<ImageModel> saveImage(ImageModel image) => collection.save(image);
}
