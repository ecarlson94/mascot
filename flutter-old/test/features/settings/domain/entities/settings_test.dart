import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/test_context.dart';

main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('Settings', () {
    group('copyWith', () {
      test('should copy original object when no parameters are passed', () {
        // arrange
        var settings = context.data.settings;

        // act
        var result = settings.copyWith();

        // assert
        expect(result, settings);
      });

      test('should copy original object with new favoriteMascotId', () {
        // arrange
        var settings = context.data.settings;
        var expectedFavoriteMascotId = 20;

        // act
        var result =
            settings.copyWith(favoriteMascotId: expectedFavoriteMascotId);

        // assert
        expect(result.favoriteMascotId, expectedFavoriteMascotId);
      });
    });
  });
}
