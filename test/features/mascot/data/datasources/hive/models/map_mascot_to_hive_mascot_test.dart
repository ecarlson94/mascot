import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/map_mascot_to_hive_mascot.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapMascotToHiveMascot mapMascotToHiveMascot;

  setUp(() {
    context = TestContext();
    mapMascotToHiveMascot = context.data.mapMascotToHiveMascot;
  });

  group('MapMascotToHiveMascot', () {
    test('should return a MascotModel when the input is valid', () {
      // arrange
      var expectedMascotModel = context.data.hiveMascot;
      var inputMascot = context.data.mascot;

      // act
      final result = mapMascotToHiveMascot.map(inputMascot);

      // assert
      expect(result, expectedMascotModel);
    });

    test('reverse should return a Mascot when the input is valid', () {
      // arrange
      var expectedMascot = context.data.mascot;
      var inputMascotModel = context.data.hiveMascot;

      // act
      final result = mapMascotToHiveMascot.reverse(inputMascotModel);

      // assert
      expect(result, expectedMascot);
    });
  });
}
