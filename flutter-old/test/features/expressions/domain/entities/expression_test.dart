import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  group('Expression entity', () {
    late TestContext context;
    setUp(() {
      context = TestContext();
    });

    group('copyWith', () {
      test('should copy original object when no parameters are passed', () {
        // arrange
        var expression = context.data.expression;

        // act
        var result = expression.copyWith();

        // assert
        expect(result, expression);
      });

      test('should copy original object with new id', () {
        // arrange
        var expression = context.data.expression;
        var expectedId = 20;

        // act
        var result = expression.copyWith(id: expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.name, expression.name);
        expect(result.description, expression.description);
        expect(result.image, expression.image);
      });

      test('should copy original object with new name', () {
        // arrange
        var expression = context.data.expression;
        var expectedName = 'new name';

        // act
        var result = expression.copyWith(name: expectedName);

        // assert
        expect(result.id, expression.id);
        expect(result.name, expectedName);
        expect(result.description, expression.description);
        expect(result.image, expression.image);
      });

      test('should copy original object with new description', () {
        // arrange
        var expression = context.data.expression;
        var expectedDescription = 'new description';

        // act
        var result = expression.copyWith(description: expectedDescription);

        // assert
        expect(result.id, expression.id);
        expect(result.name, expression.name);
        expect(result.description, expectedDescription);
        expect(result.image, expression.image);
      });

      test('should copy original object with new image', () {
        // arrange
        var expression = context.data.expression;
        var expectedImage = Uint8List(220);

        // act
        var result = expression.copyWith(image: expectedImage);

        // assert
        expect(result.id, expression.id);
        expect(result.name, expression.name);
        expect(result.description, expression.description);
        expect(result.image, expectedImage);
      });
    });
  });
}
