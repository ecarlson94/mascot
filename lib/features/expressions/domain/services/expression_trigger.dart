import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/stream_subscriber.dart';
import '../entities/expression.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../settings/domain/repositories/settings_repository.dart';

abstract class ExpressionTrigger {
  final Expression expression;

  const ExpressionTrigger(this.expression);

  bool get isTriggered;

  FutureOr<Stream<ExpressionTrigger>> get stream;
}

class AlwaysExpressionTrigger extends ExpressionTrigger {
  const AlwaysExpressionTrigger(super.expression);

  @override
  bool get isTriggered => true;

  @override
  Stream<ExpressionTrigger> get stream => Stream.value(this);
}

class NeverExpressionTrigger extends ExpressionTrigger {
  const NeverExpressionTrigger(super.expression);

  @override
  bool get isTriggered => false;

  @override
  Stream<ExpressionTrigger> get stream => Stream.value(this);
}

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

@injectable
class ExpressionTriggerFactory implements Disposable {
  final SettingsRepository settingsRepository;
  final StreamMicrophoneVolume streamMicrophoneVolume;
  final List<SubscriptionDisposer> _disposers = [];

  ExpressionTriggerFactory(
    this.settingsRepository,
    this.streamMicrophoneVolume,
  );

  ExpressionTrigger create(Expression expression) {
    switch (expression.activator) {
      case ExpressionTriggers.always:
        return AlwaysExpressionTrigger(expression);
      case ExpressionTriggers.never:
        return NeverExpressionTrigger(expression);
      case ExpressionTriggers.talking:
        var talkingExpressionTrigger = TalkingExpressionTrigger(
          expression,
          settingsRepository,
          streamMicrophoneVolume,
        );
        _disposers.add(talkingExpressionTrigger);
        return talkingExpressionTrigger;
      default:
        throw Exception('Unknown expression trigger');
    }
  }

  @override
  FutureOr onDispose() {
    for (var disposer in _disposers) {
      disposer.onDispose();
    }
  }
}
