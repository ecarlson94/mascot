import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../../core/data/stream_subscriber.dart';
import '../../../../microphone/domain/models/decibel_lufs.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'expression_trigger.dart';

class TalkingExpressionTrigger extends ExpressionTrigger
    with SubscriptionDisposer
    implements StreamSubcriber {
  final SettingsRepository _settingsRepository;
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  TalkingExpressionTrigger(
    super.expression,
    this._settingsRepository,
    this._streamMicrophoneVolume,
  );

  bool _isTriggered = false;
  @override
  bool get isTriggered => _isTriggered;

  @override
  Future<Stream<ExpressionTrigger>> get stream async {
    var stream = BehaviorSubject.seeded(this);

    DecibelLufs talkingThreshold = const DecibelLufs(-10);
    DecibelLufs microphoneVolume = const DecibelLufs(-40);

    var settingsStreamOrFailure = await _settingsRepository.streamSettings();
    settingsStreamOrFailure.fold(
      (l) => stream.addError(l),
      (settingsStream) {
        var settingsSub = settingsStream.listen((event) {
          talkingThreshold = event.talkingThreshold;
          _addTrigger(microphoneVolume, talkingThreshold, stream);
        });
        subscriptions.add(settingsSub);
      },
    );

    var volumeStreamOrFailure = await _streamMicrophoneVolume(NoParams());
    volumeStreamOrFailure.fold(
      (l) => stream.addError(l),
      (volumeStream) {
        var volumeSub = volumeStream.listen((event) {
          microphoneVolume = event;
          _addTrigger(event, talkingThreshold, stream);
        });
        subscriptions.add(volumeSub);
      },
    );

    return stream;
  }

  void _addTrigger(DecibelLufs event, DecibelLufs talkingThreshold,
      BehaviorSubject<TalkingExpressionTrigger> stream) {
    var newIsTriggered = event.value >= talkingThreshold.value;
    if (_isTriggered != newIsTriggered) {
      _isTriggered = newIsTriggered;
      stream.add(this);
    }
  }
}
