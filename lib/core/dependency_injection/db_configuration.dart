import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../features/images/data/models/image_model.dart';

@Singleton(as: Isar)
abstract class IsarSingleton implements Isar {
  @factoryMethod
  static Future<Isar> create() => Isar.open([ImageModelSchema]);
}
