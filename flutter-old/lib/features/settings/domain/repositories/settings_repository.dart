import 'package:dartz/dartz.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../entities/settings.dart';

typedef SettingsSingle = Single<Settings>;
typedef SettingsStream = Stream<Settings>;
typedef UnitSingle = Single<Unit>;

abstract class SettingsRepository {
  /// Gets the current application settings.
  SettingsSingle loadSettings();

  /// Stream of the current application settings.
  /// This is useful for when you want to listen to changes in the settings
  /// and update the UI accordingly.
  SettingsStream streamSettings();

  /// Saves the favorite mascot id.
  UnitSingle setFavoriteMascotId(Id id);

  /// Saves the talking threshold.
  UnitSingle setTalkingThreshold(DecibelLufs threshold);
}
