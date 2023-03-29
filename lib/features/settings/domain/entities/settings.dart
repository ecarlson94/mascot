import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({required Id? favoriteMascotId}) = _Settings;

  static const Settings empty = Settings(favoriteMascotId: null);
}
