import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  group('Mascot entity', () {
    late TestContext context;
    setUp(() {
      context = TestContext();
    });

    group('copyWith', () {
      test('should copy original object when no parameters are passed', () {
        // arrange
        var mascot = context.data.mascot;

        // act
        var result = mascot.copyWith();

        // assert
        expect(result, mascot);
      });

      test('should copy original object with new id', () {
        // arrange
        var mascot = context.data.mascot;
        var expectedId = 20;

        // act
        var result = mascot.copyWith(id: expectedId);

        // assert
        expect(result.id, expectedId);
        expect(result.name, mascot.name);
        expect(result.expressions, mascot.expressions);
      });

      test('should copy original object with new name', () {
        // arrange
        var mascot = context.data.mascot;
        var expectedName = 'new name';

        // act
        var result = mascot.copyWith(name: expectedName);

        // assert
        expect(result.id, mascot.id);
        expect(result.name, expectedName);
        expect(result.expressions, mascot.expressions);
      });

      test('should copy original object with new expressions', () {
        // arrange
        var mascot = context.data.mascot;
        var expectedExpressions = {context.data.expression};

        // act
        var result = mascot.copyWith(expressions: expectedExpressions);

        // assert
        expect(result.id, mascot.id);
        expect(result.name, mascot.name);
        expect(result.expressions, expectedExpressions);
      });
    });
  });
}
