import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../models/settings_model.dart';
import 'models/hive_settings.dart';
import 'models/map_settings_to_hive_settings.dart';

abstract class SettingsHiveDataSource {
  /// Gets the current application settings
  Future<SettingsModel> loadSettings();

  /// Stream of the current application settings
  /// This is useful for when you want to listen to changes in the settings
  /// and update the UI accordingly.
  Future<Stream<SettingsModel?>> streamSettings();

  /// Saves the favorite mascot id
  Future<Unit> saveSettings(SettingsModel settings);
}

@Injectable(as: SettingsHiveDataSource)
class SettingsHiveDataSourceImpl implements SettingsHiveDataSource {
  static const int _settingsId = 1;
  final HiveCollectionAdapter<HiveSettings> collection;
  final MapSettingsToHiveSettings _mapSettingsToHiveSettings;

  SettingsHiveDataSourceImpl(this.collection, this._mapSettingsToHiveSettings);

  @override
  Future<SettingsModel> loadSettings() async {
    if (!(await collection.contains(_settingsId))) {
      await collection.add(const HiveSettings(favoriteMascotId: 0));
    }
    return await collection.get(_settingsId);
  }

  @override
  Future<Unit> saveSettings(SettingsModel settings) async {
    await collection.add(_mapSettingsToHiveSettings.map(settings));
    return unit;
  }

  @override
  Future<Stream<SettingsModel?>> streamSettings() =>
      collection.stream(_settingsId);
}
