import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/data/collection_adapter.dart';
import '../../../../core/data/hive_collection_adapter.dart';
import '../models/image_model.dart';

// @module // Uncomment when enabling Isar
abstract class IsarImagesCollection {
  @lazySingleton
  IsarCollection<ImageModel> create(Isar isar) {
    return isar.collection<ImageModel>();
  }
}

@module
abstract class HiveImagesCollection {
  @singleton
  @preResolve
  Future<Box<ImageModel>> create(
    HiveInterface hive,
  ) async {
    hive.registerAdapter(ImageModelAdapter());
    return hive.openBox<ImageModel>('images');
  }
}

@module
abstract class ImagesCollectionAdapter {
  @factoryMethod
  CollectionAdapter<ImageModel> create(
    Box<ImageModel> collection,
  ) {
    return HiveCollectionAdapter<ImageModel>(collection);
  }
}
