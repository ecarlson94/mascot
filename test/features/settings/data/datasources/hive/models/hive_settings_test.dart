import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  group('HiveModel', () {
    late TestContext context;
    setUp(() {
      context = TestContext();
    });

    group('copyWithId', () {
      test('should force id to be one', () {
        // arrange
        var settingsModel = context.data.hiveSettings;
        var expectedId = 1;

        // act
        var result = settingsModel.copyWithId(20);

        // assert
        expect(result.id, expectedId);
        expect(result.favoriteMascotId, settingsModel.favoriteMascotId);
      });
    });
  });
}
