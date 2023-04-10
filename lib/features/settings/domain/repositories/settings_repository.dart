import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../entities/settings.dart';

typedef FailureOrSettingsFuture = Future<Either<Failure, Settings>>;
typedef FailureOrSettingsSubjectFuture
    = Future<Either<Failure, BehaviorSubject<Settings>>>;

abstract class SettingsRepository {
  /// Gets the current application settings.
  FailureOrSettingsFuture loadSettings();

  /// Stream of the current application settings.
  /// This is useful for when you want to listen to changes in the settings
  /// and update the UI accordingly.
  FailureOrSettingsSubjectFuture streamSettings();

  /// Saves the favorite mascot id.
  Future<Either<Failure, Unit>> setFavoriteMascotId(Id id);

  /// Saves the talking threshold.
  Future<Either<Failure, Unit>> setTalkingThreshold(DecibelLufs threshold);
}
