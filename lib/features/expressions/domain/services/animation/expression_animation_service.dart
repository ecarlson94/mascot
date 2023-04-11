import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/data/stream_subscriber.dart';
import '../../entities/expression.dart';
import 'expression_trigger_factory.dart';

abstract class ExpressionAnimationService {
  Future<Stream<Expression>> animateExpressions(Set<Expression> expressions);
}

@Injectable(as: ExpressionAnimationService)
class ExpressionAnimationServiceImpl extends ExpressionAnimationService
    with SubscriptionDisposer
    implements StreamSubcriber {
  final Map<String, Expression> _triggeredExpressions = {};
  final ExpressionTriggerFactory expressionTriggerFactory;

  ExpressionAnimationServiceImpl(
    this.expressionTriggerFactory,
  );

  @override
  Future<Stream<Expression>> animateExpressions(
      Set<Expression> expressions) async {
    var expressionStream = BehaviorSubject<Expression>();
    var triggers = expressions.map((e) {
      return expressionTriggerFactory.create(e);
    }).toList();

    for (var trigger in triggers) {
      var triggerStream = await trigger.stream;
      var triggerSub = triggerStream.listen((trigger) {
        if (trigger.isTriggered) {
          _triggeredExpressions[trigger.expression.name] = trigger.expression;
        } else {
          _triggeredExpressions.remove(trigger.expression.name);
        }

        _addCurrentExpression(expressionStream);
      });
      subscriptions.add(triggerSub);
    }

    return expressionStream;
  }

  void _addCurrentExpression(BehaviorSubject<Expression> expressionStream) {
    var currentExpression = _getCurrentExpression();
    if (!expressionStream.hasValue ||
        expressionStream.value != currentExpression) {
      expressionStream.add(currentExpression);
    }
  }

  Expression _getCurrentExpression() {
    return _triggeredExpressions.values.reduce(
      (previous, current) {
        if (previous.priority < current.priority) {
          return previous;
        } else {
          return current;
        }
      },
    );
  }
}
