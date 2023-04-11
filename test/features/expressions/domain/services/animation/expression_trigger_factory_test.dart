import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/expressions/domain/services/animation/expression_trigger.dart';
import 'package:mascot/features/expressions/domain/services/animation/expression_trigger_factory.dart';
import 'package:mascot/features/expressions/domain/services/animation/talking_expression_trigger.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionTriggerFactory factory;

  setUp(() {
    context = TestContext();
    factory = ExpressionTriggerFactory(
      context.mocks.settingsRepository,
      context.mocks.streamMicrophoneVolume,
    );
  });

  group('ExpressionTriggerFactory', () {
    var inputsToExpectations = {
      ExpressionTriggers.always: AlwaysExpressionTrigger,
      ExpressionTriggers.never: NeverExpressionTrigger,
      ExpressionTriggers.talking: TalkingExpressionTrigger,
    };
    for (var input in inputsToExpectations.keys) {
      test('should return ${inputsToExpectations[input]} for $input', () {
        var expression = Expression(
          id: 1,
          name: 'name',
          description: 'description',
          image: Uint8List(0),
          activator: input,
          priority: 1,
        );

        var expectedTriggerType = inputsToExpectations[input];
        var result = factory.create(expression);
        expect(result.runtimeType, expectedTriggerType);
      });
    }

    test('should dispose of TalkingExpressionTrigger', () async {
      // arrange
      var expression = Expression(
        id: 1,
        name: 'name',
        description: 'description',
        image: Uint8List(0),
        activator: ExpressionTriggers.talking,
        priority: 1,
      );
      var result = factory.create(expression) as TalkingExpressionTrigger;
      result.subscriptions.add(context.mocks.streamSubcriber);

      // act
      await factory.onDispose();

      // assert
      verify(context.mocks.streamSubcriber.cancel());
    });
  });
}
