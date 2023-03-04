import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/data/collection_adapter.dart';
import '../../../../core/data/hive_collection_adapter.dart';
import '../models/expression_model.dart';
import '../models/mascot_model.dart';

// @module // Uncomment when enabling Isar
abstract class IsarMascotsCollection {
  @factoryMethod
  IsarCollection<MascotModel> create(Isar isar) {
    return isar.collection<MascotModel>();
  }
}

@module
abstract class HiveMascotsCollection {
  @preResolve
  Future<Box<MascotModel>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(MascotModelAdapter());
    hive.registerAdapter(ExpressionModelAdapter());
    return hive.openBox<MascotModel>('mascots');
  }
}

@module
abstract class MascotsCollectionAdapter {
  @lazySingleton
  CollectionAdapter<MascotModel> create(
    Box<MascotModel> collection,
  ) {
    return HiveCollectionAdapter<MascotModel>(collection);
  }
}
