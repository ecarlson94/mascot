import 'package:injectable/injectable.dart';

import '../../../../../../core/clean_architecture/base_bloc.dart';
import '../../../../../expressions/domain/services/animation/expression_animation_service.dart';
import '../mascot_animator_bloc.dart';

@injectable
class MascotUpdatedEffect extends BlocEffect<MascotAnimatorEvent, MascotUpdated,
    MascotAnimatorState> {
  final ExpressionAnimationService _expressionAnimationService;

  MascotUpdatedEffect(this._expressionAnimationService);

  @override
  Stream<MascotAnimatorEvent> call(
    MascotUpdated event,
    MascotAnimatorState state,
  ) async* {
    var animationStream = await _expressionAnimationService
        .animateExpressions(event.mascot.expressions);
    yield* animationStream.map((event) => SetExpression(event));
  }
}
