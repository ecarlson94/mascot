import 'package:injectable/injectable.dart';

import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../../expressions/domain/services/animation/expression_animation_service.dart';
import '../mascot_animator_bloc.dart';

@injectable
class MascotUpdatedEffect extends BlocEffect<MascotAnimatorEvent,
    MascotUpdatedEvent, MascotAnimatorState> {
  final ExpressionAnimationService _expressionAnimationService;

  MascotUpdatedEffect(this._expressionAnimationService);

  @override
  Stream<MascotAnimatorEvent> call(
    MascotUpdatedEvent event,
    MascotAnimatorState state,
  ) =>
      _expressionAnimationService
          .animateExpressions(event.mascot.expressions)
          .map((expression) => SetExpressionEvent(expression));
}
