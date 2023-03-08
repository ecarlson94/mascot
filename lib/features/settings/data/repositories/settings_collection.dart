// @module // Uncomment when enabling Isar
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/data/collection_adapter.dart';
import '../../../../core/data/hive_collection_adapter.dart';
import '../models/settings_model.dart';

// @module // Uncomment when enabling Isar
abstract class IsarSettingsCollection {
  @lazySingleton
  IsarCollection<SettingsModel> create(Isar isar) {
    return isar.collection<SettingsModel>();
  }
}

@module
abstract class HiveSettingsCollection {
  @singleton
  @preResolve
  Future<Box<SettingsModel>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(SettingsModelAdapter());
    return hive.openBox<SettingsModel>('settings');
  }
}

@module
abstract class SettingsCollectionAdapter {
  @factoryMethod
  CollectionAdapter<SettingsModel> create(
    Box<SettingsModel> collection,
  ) {
    return HiveCollectionAdapter<SettingsModel>(collection);
  }
}
