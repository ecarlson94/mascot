import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/single.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../entities/expression.dart';
import 'expression_trigger.dart';
import 'expression_trigger_factory.dart';

abstract class ExpressionAnimationService {
  Stream<Expression> animateExpressions(Set<Expression> expressions);
}

@Injectable(as: ExpressionAnimationService)
class ExpressionAnimationServiceImpl extends ExpressionAnimationService {
  final ExpressionTriggerFactory expressionTriggerFactory;

  ExpressionAnimationServiceImpl(
    this.expressionTriggerFactory,
  );

  @override
  Stream<Expression> animateExpressions(Set<Expression> expressions) {
    final Map<Id, ExpressionTrigger> triggeredExpressions = {};

    return expressions
        .map(expressionTriggerFactory.create)
        .map((trigger) => trigger.stream)
        .mergeStreams()
        .doOnData((trigger) {
          if (trigger.isTriggered) {
            triggeredExpressions[trigger.expression.id] = trigger;
          } else if (triggeredExpressions.containsKey(trigger.expression.id)) {
            triggeredExpressions.remove(trigger.expression.id);
          }
        })
        .map((_) =>
            _reduceTriggersToExpression(triggeredExpressions.values.toList()))
        // Ignore consecutive duplicate expressions
        .distinct();
  }

  Expression _reduceTriggersToExpression(
    List<ExpressionTrigger> triggers,
  ) =>
      triggers
          .where((trigger) => trigger.isTriggered)
          // Select the expression of each triggered trigger
          .map((trigger) => trigger.expression)
          // Select the expression with the highest priority (lowest value)
          .reduce((previous, element) =>
              previous.priority < element.priority ? previous : element);
}
