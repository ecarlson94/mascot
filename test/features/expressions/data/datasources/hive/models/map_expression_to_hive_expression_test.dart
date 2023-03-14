import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/map_expression_to_hive_expression.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/map_image_to_hive_image.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapExpressionToHiveExpression mapExpressionToHiveExpression;
  setUp(() {
    context = TestContext();
    mapExpressionToHiveExpression =
        MapExpressionToHiveExpression(MapImageToHiveImage());
  });

  group('MapExpressionToHiveExpression', () {
    test('should return an ExpressionModel when the input is valid', () {
      // arrange
      var expectedExpressionModel = context.data.hiveMascot.expressions.first;
      var inputExpression = context.data.hiveMascot.expressions.first;

      // act
      final result = mapExpressionToHiveExpression.map(inputExpression);

      // assert
      expect(result, expectedExpressionModel);
    });

    test('reverse should return an Expression when the input is valid', () {
      // arrange
      var expectedExpression = context.data.mascot.expressions.first;
      var inputExpressionModel = context.data.hiveMascot.expressions.first;

      // act
      final result =
          mapExpressionToHiveExpression.reverse(inputExpressionModel);

      // assert
      expect(result, expectedExpression);
    });
  });
}
