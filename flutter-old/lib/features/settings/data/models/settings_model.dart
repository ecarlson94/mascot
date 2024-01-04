import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';
import 'record_settings_model.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel extends Entity with _$SettingsModel {
  const factory SettingsModel({
    required Id id,
    required Id? favoriteMascotId,
    required double talkingThresholdDecibels,
    required RecordSettingsModel recordSettings,
  }) = _SettingsModel;

  static const SettingsModel empty = SettingsModel(
    id: 1,
    favoriteMascotId: null,
    talkingThresholdDecibels: -10,
    recordSettings: RecordSettingsModel.empty,
  );
}
