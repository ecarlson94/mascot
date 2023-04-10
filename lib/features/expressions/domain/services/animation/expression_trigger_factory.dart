import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/stream_subscriber.dart';
import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import '../../entities/expression.dart';
import 'expression_trigger.dart';
import 'talking_expression_trigger.dart';

// TODO: write tests for this class
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
