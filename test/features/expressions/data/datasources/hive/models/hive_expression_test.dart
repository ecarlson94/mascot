import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  group('ExpressionModel', () {
    TestContext context = TestContext();
    setUp(() {
      context = TestContext();
    });

    group('copyWithId', () {
      test('should copy object with new id', () {
        // arrange
        var expressionModel = context.data.hiveExpression;
        var expectedId = 20;

        // act
        var result = expressionModel.copyWithId(expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.name, expressionModel.name);
        expect(result.description, expressionModel.description);
        expect(result.image, expressionModel.image);
      });
    });
  });
}
