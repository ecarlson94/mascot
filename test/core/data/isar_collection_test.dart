import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/isar_collection.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/test_context.dart';
import '../../fixtures/test_model.dart';

class TestIsarCollection extends IsarCollection<TestModel> {
  TestIsarCollection(super.collection);
}

void main() {
  late TestContext context;
  late TestIsarCollection collection;
  late TestModel model;

  setUp(() async {
    context = TestContext();
    collection = TestIsarCollection(context.mocks.isarTestCollection);
    model = const TestModel(id: 1, name: 'test');
  });

  group('get', () {
    test('should return ImageModel from local database', () async {
      // arrange
      when(context.mocks.isarTestCollection.get(any))
          .thenAnswer((_) async => model);

      // act
      final result = await collection.get(1);

      // assert
      expect(result, model);
      verify(context.mocks.isarTestCollection.get(1));
      verifyNoMoreInteractions(context.mocks.isarTestCollection);
    });

    test('should throw Exception when image is not found', () async {
      // arrange
      when(context.mocks.isarTestCollection.get(any))
          .thenAnswer((_) async => null);

      // act
      final call = collection.get;

      // assert
      expect(() => call(1), throwsException);
    });

    test('should throw Exception when id is null', () async {
      // arrange
      when(context.mocks.isarTestCollection.get(any))
          .thenAnswer((_) async => null);

      // act
      final call = collection.get;

      // assert
      expect(() => call(null), throwsException);
    });
  });

  group('save', () {
    test(
      'should return ImageModel from local database after saving image to database',
      () async {
        // arrange
        when(context.mocks.isarTestCollection.put(any))
            .thenAnswer((_) async => 1);
        when(context.mocks.isarTestCollection.get(any))
            .thenAnswer((_) async => model);

        // act
        final result = await collection.save(model);

        // assert
        expect(result, model);
        verifyInOrder([
          context.mocks.isarTestCollection.put(model),
          context.mocks.isarTestCollection.get(1),
        ]);
        verifyNoMoreInteractions(context.mocks.isarTestCollection);
      },
    );
  });
}
