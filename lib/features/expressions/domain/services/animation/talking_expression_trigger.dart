import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../microphone/domain/models/decibel_lufs.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'expression_trigger.dart';

class TalkingExpressionTrigger extends ExpressionTrigger implements Equatable {
  static const DecibelLufs _defaultMicrophoneVolume = DecibelLufs(-40);

  final SettingsRepository _settingsRepository;
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  @override
  final bool isTriggered = false;

  TalkingExpressionTrigger(
    super.expression,
    this._settingsRepository,
    this._streamMicrophoneVolume, {
    bool isTriggered = false,
  });

  @override
  Stream<TalkingExpressionTrigger> get stream {
    DecibelLufs talkingThreshold = const DecibelLufs(-10);

    return _settingsRepository.streamSettings().switchMap(
          (settings) => Stream.value(_defaultMicrophoneVolume)
              .concatWith([_streamMicrophoneVolume(NoParams())])
              .map((volume) => volume.value >= talkingThreshold.value)
              .map((newIsTriggered) => TalkingExpressionTrigger(
                    expression,
                    _settingsRepository,
                    _streamMicrophoneVolume,
                    isTriggered: newIsTriggered,
                  ))
              .distinct(),
        );
  }

  @override
  List<Object?> get props => [expression, isTriggered];

  @override
  bool? get stringify => false;
}
