import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/data/repositories/map_expression_to_expression_model.dart';
import 'package:mascot/features/mascot/data/repositories/map_mascot_to_mascot_model.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapMascotToMascotModel mapMascotToMascotModel;

  setUp(() {
    context = TestContext();
    mapMascotToMascotModel = MapMascotToMascotModel(
      MapExpressionToExpressionModel(),
    );
  });

  group('MapMascotToMascotModel', () {
    test('should return a MascotModel when the input is valid', () {
      // arrange
      var expectedMascotModel = context.data.mascotModel;
      var inputMascot = context.data.mascot;

      // act
      final result = mapMascotToMascotModel(inputMascot);

      // assert
      expect(result, expectedMascotModel);
    });
  });
}
