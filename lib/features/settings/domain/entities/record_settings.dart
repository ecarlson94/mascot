import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_settings.freezed.dart';

class Seconds extends Equatable {
  final int value;

  const Seconds(this.value);

  @override
  List<Object?> get props => [value];
}

@freezed
class RecordSettings with _$RecordSettings {
  const factory RecordSettings({
    required int fps,
    required bool holdToRecord,
    required Seconds delay,
    required Seconds duration,
  }) = _RecordSettings;

  static const RecordSettings empty = RecordSettings(
    fps: 24,
    holdToRecord: true,
    delay: Seconds(2),
    duration: Seconds(6),
  );
}
