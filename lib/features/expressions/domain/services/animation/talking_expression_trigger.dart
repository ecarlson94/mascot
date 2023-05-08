import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../../core/reactive/stream_subscriber.dart';
import '../../../../microphone/domain/models/decibel_lufs.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'expression_trigger.dart';

class TalkingExpressionTrigger extends ExpressionTrigger
    with SubscriptionDisposer
    implements StreamSubcriber {
  final SettingsRepository _settingsRepository;
  final StreamMicrophoneVolume _streamMicrophoneVolume;
  final BehaviorSubject<TalkingExpressionTrigger> _stream = BehaviorSubject();

  TalkingExpressionTrigger(
    super.expression,
    this._settingsRepository,
    this._streamMicrophoneVolume,
  ) {
    _stream.add(this);
  }

  bool _isTriggered = false;
  @override
  bool get isTriggered => _isTriggered;

  @override
  Stream<ExpressionTrigger> get stream async* {
    DecibelLufs talkingThreshold = const DecibelLufs(-10);
    DecibelLufs microphoneVolume = const DecibelLufs(-40);

    var settingsStreamOrFailure = await _settingsRepository.streamSettings();
    settingsStreamOrFailure.fold(
      (l) => _stream.addError(l),
      (settingsStream) {
        var settingsSub = settingsStream.listen((event) {
          talkingThreshold = event.talkingThreshold;
          _addTrigger(microphoneVolume, talkingThreshold);
        });
        subscriptions.add(settingsSub);
      },
    );

    var volumeStreamOrFailure = await _streamMicrophoneVolume(NoParams());
    volumeStreamOrFailure.fold(
      (l) => _stream.addError(l),
      (volumeStream) {
        var volumeSub = volumeStream.listen((event) {
          microphoneVolume = event;
          _addTrigger(event, talkingThreshold);
        });
        subscriptions.add(volumeSub);
      },
    );

    yield* _stream;
  }

  void _addTrigger(DecibelLufs event, DecibelLufs talkingThreshold) {
    var newIsTriggered = event.value >= talkingThreshold.value;
    if (_isTriggered != newIsTriggered) {
      _isTriggered = newIsTriggered;
      _stream.add(this);
    }
  }
}
