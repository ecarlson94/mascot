import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/data/hive_collection.dart' as custom;
import '../models/image_model.dart';

// @module
abstract class IsarImagesCollection implements IsarCollection<ImageModel> {
  @factoryMethod
  IsarCollection<ImageModel> create(Isar isar) {
    return isar.collection<ImageModel>();
  }
}

@module
abstract class HiveImagesCollection {
  @preResolve
  Future<Box<ImageModel>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(ImageModelAdapter());
    return hive.openBox<ImageModel>('images');
  }
}

@lazySingleton
class LocalImages extends custom.HiveCollection<ImageModel> {
  LocalImages(super.collection);
}
