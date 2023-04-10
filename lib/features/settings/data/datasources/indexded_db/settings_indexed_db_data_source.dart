import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../models/settings_model.dart';

@lazySingleton
class SettingsIndexedDbDataSource
    extends IndexedDbDataSourceImpl<SettingsModel> {
  SettingsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  Future<SettingsModel> getObject(Id id) async {
    var optionSettings = await super.getOptionObject(id);
    return optionSettings.fold(
      () async {
        var settings = SettingsModel.empty;
        await putObject(settings);
        return settings;
      },
      (s) => s,
    );
  }

  @override
  SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'] as int,
      favoriteMascotId: json['favoriteMascotId'] as int?,
      talkingThresholdDecibels: json['talkingThresholdDecibels'] as double?,
    );
  }

  @override
  Map<String, dynamic> toJson(SettingsModel object) {
    return {
      'id': object.id,
      'favoriteMascotId': object.favoriteMascotId,
      'talkingThresholdDecibels': object.talkingThresholdDecibels,
    };
  }
}
