import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/data/repositories/map_image_to_image_model.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MapImageToImageModel mapImageToImageModel;

  setUp(() {
    context = TestContext();
    mapImageToImageModel = MapImageToImageModel();
  });

  group('MapImageToImageModel', () {
    test('should return an ImageModel when the input is valid', () {
      // act
      final result = mapImageToImageModel(context.data.image);

      // assert
      expect(result, context.data.imageModel);
    });
  });
}
