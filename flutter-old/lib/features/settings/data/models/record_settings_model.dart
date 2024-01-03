import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_settings_model.freezed.dart';

class SecondsModel extends Equatable {
  final int value;

  const SecondsModel(this.value);

  @override
  List<Object?> get props => [value];
}

@freezed
class RecordSettingsModel with _$RecordSettingsModel {
  const factory RecordSettingsModel({
    required int fps,
    required bool holdToRecord,
    required SecondsModel delay,
    required SecondsModel duration,
  }) = _RecordSettingsModel;

  static const RecordSettingsModel empty = RecordSettingsModel(
    fps: 24,
    holdToRecord: true,
    delay: SecondsModel(2),
    duration: SecondsModel(6),
  );
}
