import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/collection_adapter.dart';
import '../models/image_model.dart';

abstract class ImagesLocalDataSource {
  /// Saves an image to the local database.
  Future<ImageModel> saveImage(ImageModel image);

  /// Gets an image from the local database.
  Future<ImageModel> getImage(Id? id);
}

@LazySingleton(as: ImagesLocalDataSource)
class ImagesLocalDataSourceImpl implements ImagesLocalDataSource {
  final CollectionAdapter<ImageModel> collection;

  ImagesLocalDataSourceImpl(this.collection);

  @override
  Future<ImageModel> getImage(Id? id) {
    return collection.get(id);
  }

  @override
  Future<ImageModel> saveImage(ImageModel image) => collection.save(image);
}
