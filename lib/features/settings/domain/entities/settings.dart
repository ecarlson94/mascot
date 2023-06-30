import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mascot/features/settings/domain/entities/record_settings.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required Id? favoriteMascotId,
    required DecibelLufs talkingThreshold,
    required RecordSettings recordSettings,
  }) = _Settings;

  static const Settings empty = Settings(
    favoriteMascotId: null,
    talkingThreshold: DecibelLufs(-10),
    recordSettings: RecordSettings.empty,
  );
}
