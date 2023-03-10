import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../models/mascot_model.dart';

@module
abstract class HiveMascotsCollection {
  @singleton
  @preResolve
  Future<Box<MascotModel>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(HiveMascotAdapter());
    return hive.openBox<MascotModel>('mascots');
  }
}

@module
abstract class MascotsCollectionAdapter {
  @factoryMethod
  HiveCollectionAdapter<MascotModel> create(
    Box<MascotModel> collection,
  ) {
    return HiveCollectionAdapter<MascotModel>(collection);
  }
}
