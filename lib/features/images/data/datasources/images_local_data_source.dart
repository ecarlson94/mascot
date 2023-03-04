import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/collection_adapter.dart';
import '../models/image_model.dart';

abstract class ImagesLocalDataSource {
  /// Saves an image to the local database.
  Future<Id> addImage(ImageModel image);

  /// Gets an image from the local database.
  Future<ImageModel> getImage(Id id);

  /// Removes an image from the local database.
  Future<void> removeImage(Id id);

  /// Gets several images from the local database.
  Future<List<ImageModel>> getImages(List<Id> ids);
}

@Injectable(as: ImagesLocalDataSource)
class ImagesLocalDataSourceImpl implements ImagesLocalDataSource {
  final CollectionAdapter<ImageModel> collection;

  ImagesLocalDataSourceImpl(this.collection);

  @override
  Future<ImageModel> getImage(Id id) => collection.get(id);

  @override
  Future<Id> addImage(ImageModel image) => collection.add(image);

  @override
  Future<void> removeImage(Id id) => collection.remove(id);

  @override
  Future<List<ImageModel>> getImages(List<Id> ids) => collection.getMany(ids);
}
