import 'package:injectable/injectable.dart';

import '../../domain/entities/record_settings.dart';
import 'record_settings_model.dart';

abstract class RecordSettingsMapper {
  RecordSettingsModel fromRecordSettings(RecordSettings recordSettings);
  RecordSettings toRecordSettings(RecordSettingsModel recordSettingsModel);
}

@LazySingleton(as: RecordSettingsMapper)
class RecordSettingsMapperImpl implements RecordSettingsMapper {
  @override
  RecordSettingsModel fromRecordSettings(RecordSettings recordSettings) {
    return RecordSettingsModel(
      fps: recordSettings.fps,
      holdToRecord: recordSettings.holdToRecord,
      delay: SecondsModel(recordSettings.delay.value),
      duration: SecondsModel(recordSettings.duration.value),
    );
  }

  @override
  RecordSettings toRecordSettings(RecordSettingsModel recordSettingsModel) {
    return RecordSettings(
      fps: recordSettingsModel.fps,
      holdToRecord: recordSettingsModel.holdToRecord,
      delay: Seconds(recordSettingsModel.delay.value),
      duration: Seconds(recordSettingsModel.duration.value),
    );
  }
}
