import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/isar_collection_adapter.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../fixtures/test_context.dart';
import '../../fixtures/test_model.dart';

class TestIsarCollection extends IsarCollectionAdapter<TestModel> {
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

  group('IsarCollection', () {
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
        expect(() => call(1), throwsA(isA<ArgumentException>()));
      });

      test('should throw Exception when id is 0', () async {
        // arrange
        when(context.mocks.isarTestCollection.get(any))
            .thenAnswer((_) async => null);

        // act
        final call = collection.get;

        // assert
        expect(() => call(0), throwsA(isA<ArgumentException>()));
      });
    });

    group('add', () {
      test(
        'should return ImageModel from local database after saving image to database',
        () async {
          // arrange
          when(context.mocks.isarTestCollection.put(any))
              .thenAnswer((_) async => 1);
          when(context.mocks.isarTestCollection.get(any))
              .thenAnswer((_) async => model);

          // act
          final result = await collection.add(model);

          // assert
          expect(result, model.id);
          verify(context.mocks.isarTestCollection.put(model));
          verifyNoMoreInteractions(context.mocks.isarTestCollection);
        },
      );
    });

    group('remove', () {
      test('should remove item from isar database', () {
        // arrange
        when(context.mocks.isarTestCollection.delete(any))
            .thenAnswer((_) async => Future.value(true));

        // act
        collection.remove(1);

        // assert
        verify(context.mocks.isarTestCollection.delete(1));
        verifyNoMoreInteractions(context.mocks.isarTestCollection);
      });
    });

    group('getMany', () {
      late List<TestModel> testModels;
      setUp(() {
        testModels = [
          const TestModel(id: 1, name: 'test1'),
          const TestModel(id: 2, name: 'test2'),
          const TestModel(id: 3, name: 'test3'),
        ];
      });

      test('should return ImageModel list from isar database', () async {
        // arrange
        var ids = testModels.map((e) => e.id).toList();
        when(context.mocks.isarTestCollection.getAll(any))
            .thenAnswer((_) async => testModels);

        // act
        final result = await collection.getMany(ids);

        // assert
        expect(result, testModels);
      });

      test('should throw Exception when image is not found', () async {
        // arrange
        var ids = testModels.map((e) => e.id).toList();
        when(context.mocks.isarTestCollection.getAll(any))
            .thenAnswer((_) async => testModels.sublist(0, 2));

        // act
        final call = collection.getMany;

        // assert
        expect(() => call(ids), throwsA(isA<ArgumentException>()));
      });
    });

    group('contains', () {
      test('should return true if item exists in isar database', () async {
        // arrange
        when(context.mocks.isarTestCollection.get(any))
            .thenAnswer((_) async => model);

        // act
        final result = await collection.contains(1);

        // assert
        expect(result, true);
        verify(context.mocks.isarTestCollection.get(1));
        verifyNoMoreInteractions(context.mocks.isarTestCollection);
      });

      test('should return false if item does not exist in isar database',
          () async {
        // arrange
        when(context.mocks.isarTestCollection.get(any))
            .thenAnswer((_) async => null);

        // act
        final result = await collection.contains(1);

        // assert
        expect(result, false);
        verify(context.mocks.isarTestCollection.get(1));
        verifyNoMoreInteractions(context.mocks.isarTestCollection);
      });
    });

    group('stream', () {
      test(
        'should return stream of TestModel from the isar database',
        () async {
          // arrange
          var stream = BehaviorSubject<TestModel>();
          when(context.mocks.isarTestCollection.watchObject(1))
              .thenAnswer((_) => stream);

          // act
          final result = await collection.stream(1);

          // assert
          expect(result, stream);
        },
      );
    });
  });
}
