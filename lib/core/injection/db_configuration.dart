import 'package:hive_flutter/hive_flutter.dart' as hive;
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart' as isar;

// @module // Uncomment when enabling Isar
abstract class IsarSingleton implements isar.Isar {
  @preResolve
  // static Future<isar.Isar> create() => isar.Isar.open([ImageModelSchema]); // Uncomment when enabling Isar
  static Future<isar.Isar> create() => isar.Isar.open([]);
}

@module
abstract class HiveSingleton {
  @preResolve
  Future<hive.HiveInterface> create() async {
    var hiveInstance = hive.Hive;
    await hiveInstance.initFlutter();
    return hiveInstance;
  }
}
