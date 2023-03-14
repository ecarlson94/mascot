import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/map_image_to_hive_image.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapImageToHiveImage mapImageToImageModel;

  setUp(() {
    context = TestContext();
    mapImageToImageModel = MapImageToHiveImage();
  });

  group('MapImageToImageModel', () {
    test('should return an ImageModel when the input is valid', () {
      // act
      final result = mapImageToImageModel.map(context.data.image);

      // assert
      expect(result, context.data.hiveImage);
    });

    test('reverse should return an Image when the input is valid', () {
      // act
      final result = mapImageToImageModel.reverse(context.data.hiveImage);

      // assert
      expect(result, context.data.image);
    });
  });
}
