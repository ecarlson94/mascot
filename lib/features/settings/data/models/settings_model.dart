import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel extends Entity with _$SettingsModel {
  const factory SettingsModel({
    required Id id,
    required Id? favoriteMascotId,
    required double? talkingThresholdDecibels,
  }) = _SettingsModel;

  static const SettingsModel empty = SettingsModel(
    id: 1,
    favoriteMascotId: null,
    talkingThresholdDecibels: null,
  );
}
