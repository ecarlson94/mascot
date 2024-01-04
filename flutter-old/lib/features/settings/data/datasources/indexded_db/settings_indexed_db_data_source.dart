import 'package:injectable/injectable.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mascot/features/settings/data/models/record_settings_model.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../models/settings_model.dart';

@lazySingleton
class SettingsIndexedDbDataSource
    extends IndexedDbDataSourceImpl<SettingsModel> {
  SettingsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  Single<SettingsModel> getObject(Id id) =>
      super.getObject(id).onErrorResumeSingle((error, stackTrace) {
        return error is ObjectNotFoundException
            ? putObject(SettingsModel.empty).map((event) => SettingsModel.empty)
            : Single.error(error, stackTrace);
      });

  @override
  SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'] as int,
      favoriteMascotId: json['favoriteMascotId'] as int?,
      talkingThresholdDecibels: json['talkingThresholdDecibels'] as double,
      recordSettings: _recordSettingsFromJson(
          json['recordSettings'] as Map<String, dynamic>),
    );
  }

  RecordSettingsModel _recordSettingsFromJson(Map<String, dynamic> json) {
    return RecordSettingsModel(
      fps: json['fps'] as int,
      holdToRecord: json['holdToRecord'] as bool,
      delay: SecondsModel(json['delay'] as int),
      duration: SecondsModel(json['duration'] as int),
    );
  }

  @override
  Map<String, dynamic> toJson(SettingsModel object) {
    return {
      'id': object.id,
      'favoriteMascotId': object.favoriteMascotId,
      'talkingThresholdDecibels': object.talkingThresholdDecibels,
      'recordSettings': _recordSettingsToJson(object.recordSettings),
    };
  }

  Map<String, dynamic> _recordSettingsToJson(RecordSettingsModel object) {
    return {
      'fps': object.fps,
      'holdToRecord': object.holdToRecord,
      'delay': object.delay.value,
      'duration': object.duration.value,
    };
  }
}
