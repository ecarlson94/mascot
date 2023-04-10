import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required Id? favoriteMascotId,
    required DecibelLufs? talkingThreshold,
  }) = _Settings;

  static const Settings empty = Settings(
    favoriteMascotId: null,
    talkingThreshold: null,
  );
}
