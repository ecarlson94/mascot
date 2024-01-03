import 'package:injectable/injectable.dart';

import '../../../../microphone/domain/usecases/stream_microphone_volume.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import '../../entities/expression.dart';
import 'expression_trigger.dart';
import 'talking_expression_trigger.dart';

@injectable
class ExpressionTriggerFactory {
  final SettingsRepository _settingsRepository;
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  ExpressionTriggerFactory(
    this._settingsRepository,
    this._streamMicrophoneVolume,
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
          _settingsRepository,
          _streamMicrophoneVolume,
        );
        return talkingExpressionTrigger;
      default:
        throw Exception('Unknown expression trigger');
    }
  }
}
