import 'package:hive/hive.dart' as hive;
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart' as isar;

import '../../../../core/data/hive_collection.dart';
import '../models/image_model.dart';

// @LazySingleton(as: isar.IsarCollection<ImageModel>) // Uncomment when enabling Isar
abstract class IsarImagesCollection implements isar.IsarCollection<ImageModel> {
  @factoryMethod
  static isar.IsarCollection<ImageModel> create(isar.Isar isar) {
    return isar.collection<ImageModel>();
  }
}

@LazySingleton(as: hive.CollectionBox<ImageModel>)
abstract class HiveImagesCollection implements hive.CollectionBox<ImageModel> {
  @factoryMethod
  static Future<hive.CollectionBox<ImageModel>> create(
    hive.BoxCollection boxCollection,
    hive.HiveInterface hive,
  ) {
    hive.registerAdapter(ImageModelAdapter());
    return boxCollection.openBox<ImageModel>('images');
  }
}

@lazySingleton
class LocalImages extends HiveCollection<ImageModel> {
  LocalImages(super.collection);
}
