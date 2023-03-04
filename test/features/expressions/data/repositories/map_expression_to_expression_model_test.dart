import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/repositories/map_expression_to_expression_model.dart';
import 'package:mascot/features/expressions/data/repositories/map_image_to_image_model.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapExpressionToExpressionModel mapExpressionToExpressionModel;
  setUp(() {
    context = TestContext();
    mapExpressionToExpressionModel =
        MapExpressionToExpressionModel(MapImageToImageModel());
  });

  group('MapExpressionToExpressionModel', () {
    test('should return an ExpressionModel when the input is valid', () {
      // arrange
      var expectedExpressionModel = context.data.mascotModel.expressions.first;
      var inputExpression = context.data.mascotModel.expressions.first;

      // act
      final result = mapExpressionToExpressionModel(inputExpression);

      // assert
      expect(result, expectedExpressionModel);
    });
  });
}