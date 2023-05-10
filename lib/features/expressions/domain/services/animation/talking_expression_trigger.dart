import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'expression_trigger.dart';

class TalkingExpressionTrigger extends ExpressionTrigger {
  final SettingsRepository _settingsRepository;
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  bool _isTriggered = false;
  @override
  bool get isTriggered => _isTriggered;

  TalkingExpressionTrigger(
    super.expression,
    this._settingsRepository,
    this._streamMicrophoneVolume, {
    bool isTriggered = false,
  });

  @override
  Stream<TalkingExpressionTrigger> get stream {
    return _settingsRepository.streamSettings().switchMap(
          (settings) => _streamMicrophoneVolume(NoParams())
              .map((volume) => volume.value >= settings.talkingThreshold.value)
              .map(
            (newIsTriggered) {
              _isTriggered = newIsTriggered;
              return this;
            },
          ).distinct((prev, next) => prev.isTriggered != next.isTriggered),
        );
  }
}
