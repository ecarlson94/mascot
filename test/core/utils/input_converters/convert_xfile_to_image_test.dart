import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/images/domain/entities/image.dart';

void main() {
  late ConvertXfileToImage convertXfileToImage;

  setUp(() {
    convertXfileToImage = ConvertXfileToImage();
  });

  group('ConvertXfileToImage', () {
    test('should return an Image when the input is valid', () {
      // arrange
      var input = XFile('test');

      // act
      final result = convertXfileToImage(input);

      // assert
      expect(result, Right(Image(name: input.name)));
    });

    var inputsToFailures = {
      XFile(''): 'is missing the name property',
    };
    inputsToFailures.forEach((input, failureReason) {
      test(
        'should return an InvalidInputFailure when the input is $failureReason',
        () {
          // act
          final result = convertXfileToImage(input);

          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    });
  });
}
