import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  group('HiveMascot', () {
    TestContext context = TestContext();
    setUp(() {
      context = TestContext();
    });

    group('copyWithId', () {
      test('should copy object with new id', () {
        // arrange
        var mascotModel = context.data.mascotModel;

        // act
        var result = mascotModel.copyWithId(2);

        // assert
        expect(result.id, 2);
        expect(result.name, mascotModel.name);
        expect(result.expressions, mascotModel.expressions);
      });
    });
  });
}
