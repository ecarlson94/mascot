import 'package:rxdart/rxdart.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../../core/data/stream_subscriber.dart';
import '../../../../microphone/domain/models/decibel_lufs.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'expression_trigger.dart';

// TODO: write tests for this class
class TalkingExpressionTrigger extends ExpressionTrigger
    with SubscriptionDisposer
    implements StreamSubcriber {
  final SettingsRepository settingsRepository;
  final StreamMicrophoneVolume streamMicrophoneVolume;

  TalkingExpressionTrigger(
    super.expression,
    this.settingsRepository,
    this.streamMicrophoneVolume,
  );

  bool _isTriggered = false;
  @override
  bool get isTriggered => _isTriggered;

  @override
  Future<Stream<ExpressionTrigger>> get stream async {
    var stream = BehaviorSubject.seeded(this);

    DecibelLufs talkingThreshold = const DecibelLufs(-10);
    var settingsStreamOrFailure = await settingsRepository.streamSettings();
    settingsStreamOrFailure.fold(
      (l) => stream.addError(l),
      (settingsStream) {
        var settingsSub = settingsStream.listen((event) {
          talkingThreshold = event.talkingThreshold;
        });
        subscriptions.add(settingsSub);
      },
    );

    var volumeStreamOrFailure = await streamMicrophoneVolume(NoParams());
    volumeStreamOrFailure.fold(
      (l) => stream.addError(l),
      (volumeStream) {
        var volumeSub = volumeStream.listen((event) {
          var newIsTriggered = event.value >= talkingThreshold.value;
          if (_isTriggered != newIsTriggered) {
            _isTriggered = newIsTriggered;
            stream.add(this);
          }
        });
        subscriptions.add(volumeSub);
      },
    );

    return stream;
  }
}
