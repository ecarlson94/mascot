import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/reactive/stream_subscriber.dart';
import '../../entities/expression.dart';
import 'expression_trigger_factory.dart';

abstract class ExpressionAnimationService {
  Stream<Expression> animateExpressions(Set<Expression> expressions);
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
  Stream<Expression> animateExpressions(Set<Expression> expressions) async* {
    var expressionStream = BehaviorSubject<Expression>();
    var triggers = expressions.map(expressionTriggerFactory.create).toList();

    for (var trigger in triggers) {
      var triggerStream = await trigger.stream;
      var triggerSub = triggerStream.listen((event) {
        if (event.isTriggered) {
          _triggeredExpressions[event.expression.name] = event.expression;
        } else {
          _triggeredExpressions.remove(event.expression.name);
        }

        _addCurrentExpression(expressionStream);
      });
      subscriptions.add(triggerSub);
    }

    yield* expressionStream;
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
