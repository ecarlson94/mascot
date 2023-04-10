import 'dart:async';

import '../../entities/expression.dart';

abstract class ExpressionTrigger {
  final Expression expression;

  const ExpressionTrigger(this.expression);

  bool get isTriggered;

  FutureOr<Stream<ExpressionTrigger>> get stream;
}

// TODO: write tests for this class
class AlwaysExpressionTrigger extends ExpressionTrigger {
  const AlwaysExpressionTrigger(super.expression);

  @override
  bool get isTriggered => true;

  @override
  Stream<ExpressionTrigger> get stream => Stream.value(this);
}

// TODO: write tests for this class
class NeverExpressionTrigger extends ExpressionTrigger {
  const NeverExpressionTrigger(super.expression);

  @override
  bool get isTriggered => false;

  @override
  Stream<ExpressionTrigger> get stream => Stream.value(this);
}
