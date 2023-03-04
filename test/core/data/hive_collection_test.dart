import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/hive_collection_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/test_context.dart';
import '../../fixtures/test_model.dart';

class TestHiveCollection extends HiveCollectionAdapter<TestModel> {
  TestHiveCollection(super.collection);
}

void main() {
  late TestContext context;
  late TestHiveCollection collection;
  late TestModel model;

  setUp(() async {
    context = TestContext();
    collection = TestHiveCollection(context.mocks.hiveTestCollection);
    model = const TestModel(id: 1, name: 'test');

    when(context.mocks.hiveTestCollection.get(any)).thenReturn(model);
    when(context.mocks.hiveTestCollection.length).thenReturn(0);
  });

  group('get', () {
    test('should return ImageModel from local database', () async {
      // act
      final result = await collection.get(1);

      // assert
      expect(result, model);
      verify(context.mocks.hiveTestCollection.get(1));
      verifyNoMoreInteractions(context.mocks.hiveTestCollection);
    });

    test('should throw Exception when image is not found', () async {
      // arrange
      when(context.mocks.hiveTestCollection.get(any)).thenReturn(null);

      // act
      final call = collection.get;

      // assert
      expect(() => call(1), throwsException);
    });

    test('should throw Exception when id is null', () async {
      // arrange
      when(context.mocks.hiveTestCollection.get(any)).thenReturn(null);

      // act
      final call = collection.get;

      // assert
      expect(() => call(null), throwsException);
    });
  });

  group('save', () {
    test(
      'should return ImageModel from local database after saving image',
      () async {
        // arrange
        when(context.mocks.hiveTestCollection.put(any, any))
            .thenAnswer((_) async {});

        // act
        final result = await collection.save(model);

        // assert
        expect(result, model);
        verifyInOrder([
          context.mocks.hiveTestCollection.put(model.id, model),
          context.mocks.hiveTestCollection.get(model.id),
        ]);
        verifyNoMoreInteractions(context.mocks.hiveTestCollection);
      },
    );

    test('should not auto increment id when id is not null', () async {
      // arrange
      when(context.mocks.hiveTestCollection.put(any, any))
          .thenAnswer((_) async {});
      when(context.mocks.hiveTestCollection.length).thenReturn(3);

      // act
      await collection.save(model);

      // assert
      verify(context.mocks.hiveTestCollection.put(model.id, model));
    });

    test('should auto increment id when id is null', () async {
      // arrange
      when(context.mocks.hiveTestCollection.put(any, any))
          .thenAnswer((_) async {});
      when(context.mocks.hiveTestCollection.length).thenReturn(3);
      var newModel = const TestModel(id: null, name: 'test');

      // act
      await collection.save(newModel);

      // assert
      verify(context.mocks.hiveTestCollection.put(4, newModel));
    });
  });
}
