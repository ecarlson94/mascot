import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  group('SettingsModel', () {
    late TestContext context;
    setUp(() {
      context = TestContext();
    });

    group('copyWithId', () {
      test('should copy object with new id', () {
        // arrange
        var settingsModel = context.data.settingsModel;
        var expectedId = 20;

        // act
        var result = settingsModel.copyWithId(expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.favoriteMascotId, settingsModel.favoriteMascotId);
      });
    });
  });
}
