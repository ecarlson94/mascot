import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/drift/mascot_database.dart';
import 'models/drift_settings.dart';

abstract class SettingsDriftDataSource {
  /// Gets the current application settings
  Future<DriftSettings> loadSettings();

  /// Stream of the current application settings
  /// This is useful for when you want to listen to changes in the settings
  /// and update the UI accordingly.
  Stream<DriftSettings?> streamSettings();

  /// Saves the favorite mascot id
  Future<Unit> saveSettings(DriftSettings settings);
}

@LazySingleton(as: SettingsDriftDataSource)
class SettingsDriftDataSourceImpl implements SettingsDriftDataSource {
  final MascotDatabase _database;

  SettingsDriftDataSourceImpl(this._database);

  @override
  Future<DriftSettings> loadSettings() async {
    var query = _database.select(_database.settings)
      ..where((s) => s.id.equals(1));
    var settings = await query.getSingleOrNull();

    settings ??= DriftSettings.empty;

    return settings;
  }

  @override
  Future<Unit> saveSettings(DriftSettings settings) async {
    await _database.into(_database.settings).insertOnConflictUpdate(settings);
    return unit;
  }

  @override
  Stream<DriftSettings?> streamSettings() =>
      (_database.select(_database.settings)..where((s) => s.id.equals(1)))
          .watchSingle();
}
