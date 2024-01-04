import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/services/animation/expression_trigger.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;

  setUp(() {
    context = TestContext();
  });

  group('AlwaysExpressionTrigger', () {
    test('isTriggered should return true', () {
      // assemble
      var trigger = AlwaysExpressionTrigger(context.data.expression);

      // assert
      expect(trigger.isTriggered, isTrue);
    });

    test('should return stream with this trigger', () async {
      // assemble
      var trigger = AlwaysExpressionTrigger(context.data.expression);

      // act
      var stream = trigger.stream;

      // assert
      expect(await stream.first, trigger);
    });
  });

  group('NeverExpressionTrigger', () {
    test('isTriggered should return false', () {
      // assemble
      var trigger = NeverExpressionTrigger(context.data.expression);

      // assert
      expect(trigger.isTriggered, isFalse);
    });

    test('should return stream with this trigger', () async {
      // assemble
      var trigger = NeverExpressionTrigger(context.data.expression);

      // act
      var stream = trigger.stream;

      // assert
      expect(await stream.first, trigger);
    });
  });
}
