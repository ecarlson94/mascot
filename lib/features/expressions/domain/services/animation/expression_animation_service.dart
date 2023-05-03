import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/single.dart';

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
  Stream<Expression> animateExpressions(Set<Expression> expressions) => expressions
      .map(expressionTriggerFactory.create)
      .map((trigger) => trigger.stream)
      .mergeStreams()
      // Create a stream of triggered triggers
      // TODO: this only emits the list of triggered triggers when a new trigger is triggered
      // TODO: It should emit the list of triggered triggers every time
      // TODO: a trigger is triggered or untriggered
      // TODO: maybe use a groupBy operator?
      .bufferTest((trigger) => trigger.isTriggered)
      .flatMap(_reduceTriggersToExpression)
      .singleOrError()
      // Ignore consecutive duplicate expressions
      .distinct();

  Single<Expression> _reduceTriggersToExpression(
    List<ExpressionTrigger> triggers,
  ) =>
      triggers.stream
          // Select the expression of each triggered trigger
          .map((trigger) => trigger.expression)
          // Select the expression with the highest priority (lowest value)
          .reduce((previous, element) =>
              previous.priority < element.priority ? previous : element)
          .asSingle();
}
