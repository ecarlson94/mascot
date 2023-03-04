import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/images/domain/entities/image.dart';

import '../../../fixtures/test_context.dart';
import '../../../fixtures/test_x_file.dart';

void main() {
  late TestContext context;
  late ConvertXfileToImage convertXfileToImage;

  setUp(() {
    context = TestContext();
    convertXfileToImage = ConvertXfileToImage();
  });

  group('ConvertXfileToImage', () {
    test('should return an Image when the input is valid', () async {
      // arrange
      var input = TestXFile.fromData(
        context.data.image.data,
        name: context.data.image.name,
      );

      // act
      final result = await convertXfileToImage(input);

      // assert
      expect(
        result,
        Right(
          Image(
            id: 0,
            name: context.data.xfile.name,
            data: await context.data.xfile.readAsBytes(),
          ),
        ),
      );
    });

    var inputsToFailures = {
      TestXFile.fromData(Uint8List(40), name: ''): 'missing the name property',
      TestXFile.fromData(Uint8List(0), name: 'valid'): 'byte array is empty',
    };
    inputsToFailures.forEach((input, failureReason) {
      test(
        'should return an InvalidInputFailure when the input is $failureReason',
        () async {
          // act
          final result = await convertXfileToImage(input);

          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    });
  });
}
