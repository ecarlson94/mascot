import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/hive/hive_collection_adapter.dart';
import 'models/hive_mascot.dart';

@module
abstract class HiveMascotsCollection {
  @singleton
  @preResolve
  Future<Box<HiveMascot>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(HiveMascotAdapter());
    return hive.openBox<HiveMascot>('mascots');
  }
}

@module
abstract class MascotsCollectionAdapter {
  @factoryMethod
  HiveCollectionAdapter<HiveMascot> create(
    Box<HiveMascot> collection,
  ) {
    return HiveCollectionAdapter<HiveMascot>(collection);
  }
}
