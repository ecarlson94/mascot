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

  group('HiveCollection', () {
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

      test('should throw Exception when id is zero', () async {
        // arrange
        when(context.mocks.hiveTestCollection.get(any)).thenReturn(null);

        // act
        final call = collection.get;

        // assert
        expect(() => call(0), throwsException);
      });
    });

    group('add', () {
      test(
        'should return new object id from local database after saving item',
        () async {
          // arrange
          when(context.mocks.hiveTestCollection.put(any, any))
              .thenAnswer((_) async {});

          // act
          final result = await collection.add(model);

          // assert
          expect(result, model.id);
          verify(context.mocks.hiveTestCollection.put(model.id, model));
          verifyNoMoreInteractions(context.mocks.hiveTestCollection);
        },
      );

      test('should not auto increment id when id is not null', () async {
        // arrange
        when(context.mocks.hiveTestCollection.put(any, any))
            .thenAnswer((_) async {});
        when(context.mocks.hiveTestCollection.length).thenReturn(3);

        // act
        await collection.add(model);

        // assert
        verify(context.mocks.hiveTestCollection.put(model.id, model));
      });

      test('should auto increment id when id is 0', () async {
        // arrange
        when(context.mocks.hiveTestCollection.put(any, any))
            .thenAnswer((_) async {});
        when(context.mocks.hiveTestCollection.length).thenReturn(3);
        var newModel = const TestModel(id: 0, name: 'test');

        // act
        await collection.add(newModel);

        // assert
        verify(context.mocks.hiveTestCollection.put(4, newModel));
      });

      test('should not auto increment id when id is not 0', () async {
        // arrange
        when(context.mocks.hiveTestCollection.put(any, any))
            .thenAnswer((_) async {});
        when(context.mocks.hiveTestCollection.length).thenReturn(3);
        var newModel = const TestModel(id: 1, name: 'test');

        // act
        await collection.add(newModel);

        // assert
        verifyNever(context.mocks.hiveTestCollection.put(4, newModel));
      });
    });
  });
}
