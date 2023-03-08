import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/collection_adapter.dart';
import '../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  /// Gets the current application settings
  Future<SettingsModel> loadSettings();

  /// Stream of the current application settings
  /// This is useful for when you want to listen to changes in the settings
  /// and update the UI accordingly.
  Future<Stream<SettingsModel?>> streamSettings();

  /// Saves the favorite mascot id
  Future<Unit> saveSettings(SettingsModel settings);
}

@Injectable(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const int _settingsId = 1;
  final CollectionAdapter<SettingsModel> collection;

  SettingsLocalDataSourceImpl(this.collection);

  @override
  Future<SettingsModel> loadSettings() async {
    if (!(await collection.contains(_settingsId))) {
      await collection.add(const SettingsModel(id: _settingsId));
    }
    return await collection.get(_settingsId);
  }

  @override
  Future<Unit> saveSettings(SettingsModel settings) async {
    await collection.add(settings);
    return unit;
  }

  @override
  Future<Stream<SettingsModel?>> streamSettings() =>
      collection.stream(_settingsId);
}
