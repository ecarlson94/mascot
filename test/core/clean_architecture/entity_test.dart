import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/test_model.dart';

void main() {
  group('Entity', () {
    test('props should include id', () {
      //arrange
      const id = 1;
      const entity = TestEntity(name: 'name', id: id);

      // assert
      expect(entity.props.first, id);
    });

    test('set id should throw exception', () {
      //arrange
      const id = 1;
      const entity = TestEntity(name: 'name', id: id);

      // assert
      expect(() => entity.id = 2, throwsException);
    });
  });
}
