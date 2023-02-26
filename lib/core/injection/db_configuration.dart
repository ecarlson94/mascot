import 'package:hive_flutter/hive_flutter.dart' as hive;
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart' as isar;

// @Singleton(as: isar.Isar) // Uncomment when enabling Isar
abstract class IsarSingleton implements isar.Isar {
  @factoryMethod
  // ignore: todo
  // TODO: Add the schemas to the Isar.open() call when enabling Isar
  static Future<isar.Isar> create() => isar.Isar.open([]);
}

@Singleton(as: hive.HiveInterface)
abstract class HiveSingleton implements hive.HiveInterface {
  @factoryMethod
  static Future<hive.HiveInterface> create() async {
    var hiveInstance = hive.Hive;
    await hiveInstance.initFlutter();
    return hiveInstance;
  }
}

@Singleton(as: hive.BoxCollection)
abstract class BoxCollectionSingleton implements hive.BoxCollection {
  @factoryMethod
  static Future<hive.BoxCollection> create(
    hive.HiveInterface hiveInstance,
  ) async {
    return hive.BoxCollection.open('mascot', {'images'});
  }
}
