// @module // Uncomment when enabling Isar
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/hive_settings.dart';

import '../../../../../core/data/hive/hive_collection_adapter.dart';

@module
abstract class HiveSettingsCollection {
  @singleton
  @preResolve
  Future<Box<HiveSettings>> create(
    HiveInterface hive,
  ) {
    hive.registerAdapter(HiveSettingsAdapter());
    return hive.openBox<HiveSettings>('settings');
  }
}

@module
abstract class SettingsHiveCollectionAdapter {
  @factoryMethod
  HiveCollectionAdapter<HiveSettings> create(
    Box<HiveSettings> collection,
  ) {
    return HiveCollectionAdapter<HiveSettings>(collection);
  }
}
