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

      test('should copy original object with new id', () {
        // arrange
        var settings = context.data.settings;
        var expectedId = 20;

        // act
        var result = settings.copyWith(id: expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.favoriteMascotId, settings.favoriteMascotId);
      });

      test('should copy original object with new favoriteMascotId', () {
        // arrange
        var settings = context.data.settings;
        var expectedFavoriteMascotId = 20;

        // act
        var result =
            settings.copyWith(favoriteMascotId: expectedFavoriteMascotId);

        // assert
        expect(result.id, settings.id);
        expect(result.favoriteMascotId, expectedFavoriteMascotId);
      });
    });

    group('copyWithId', () {
      test('should copy original object with new id', () {
        // arrange
        var settings = context.data.settings;
        var expectedId = 20;

        // act
        var result = settings.copyWithId(expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.favoriteMascotId, settings.favoriteMascotId);
      });
    });
  });
}
