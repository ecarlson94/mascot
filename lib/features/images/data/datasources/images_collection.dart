import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../models/image_model.dart';

@LazySingleton(as: IsarCollection<ImageModel>)
abstract class ImagesCollection implements IsarCollection<ImageModel> {
  @factoryMethod
  static IsarCollection<ImageModel> create(Isar isar) {
    return isar.imageModels;
  }
}
