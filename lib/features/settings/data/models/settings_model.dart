import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({required Id id, required Id? favoriteMascotId}) =
      _SettingsModel;

  factory SettingsModel.empty() =>
      const SettingsModel(id: 1, favoriteMascotId: null);
}
