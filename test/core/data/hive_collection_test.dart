import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/data/hive/hive_collection_adapter.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

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
      test('should return TestModel from local database', () async {
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
        expect(() => call(1), throwsA(isA<ArgumentException>()));
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
        verify(context.mocks.hiveTestCollection.put(4, newModel.copyWithId(4)));
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

    group('remove', () {
      test('should remove item from hive database', () async {
        // arrange
        when(context.mocks.hiveTestCollection.delete(any))
            .thenAnswer((_) async {});

        // act
        await collection.remove(1);

        // assert
        verify(context.mocks.hiveTestCollection.delete(1));
        verifyNoMoreInteractions(context.mocks.hiveTestCollection);
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

      test('should return ImageModel list from hive database', () async {
        // arrange
        var ids = testModels.map((e) => e.id).toList();
        when(context.mocks.hiveTestCollection.get(any)).thenAnswer(
          (_) => testModels.firstWhere(
            (element) => element.id == (_.positionalArguments.first as Id),
          ),
        );

        // act
        final result = await collection.getMany(ids);

        // assert
        for (var model in result) {
          verify(context.mocks.hiveTestCollection.get(model.id));
          expect(
            model,
            testModels.firstWhere((element) => element.id == model.id),
          );
        }
        verifyNoMoreInteractions(context.mocks.hiveTestCollection);
      });

      test('should throw Exception when image is not found', () async {
        // arrange
        var ids = testModels.map((e) => e.id).toList();
        when(context.mocks.hiveTestCollection.get(any)).thenAnswer(
          (_) => testModels.firstWhere(
            (element) => element.id == (_.positionalArguments.first as Id),
          ),
        );
        when(context.mocks.hiveTestCollection.get(3))
            .thenAnswer((realInvocation) => null);

        // act
        final call = collection.getMany;

        // assert
        expect(() => call(ids), throwsA(isA<ArgumentException>()));
      });
    });

    group('contains', () {
      test('should return true when item is in hive database', () async {
        // arrange
        when(context.mocks.hiveTestCollection.containsKey(any))
            .thenReturn(true);

        // act
        final result = await collection.contains(1);

        // assert
        expect(result, true);
        verify(context.mocks.hiveTestCollection.containsKey(1));
        verifyNoMoreInteractions(context.mocks.hiveTestCollection);
      });
    });

    group('stream', () {
      test('should return stream of TestModel from hive database', () async {
        // arrange
        var stream = BehaviorSubject<BoxEvent>();
        when(context.mocks.hiveTestCollection.watch(key: anyNamed('key')))
            .thenAnswer((_) => stream);

        // act
        final result = await collection.stream(1);
        stream.add(BoxEvent(1, model, false));

        // assert
        expect(result, emits(model));
        verify(context.mocks.hiveTestCollection.watch(key: 1));
        verifyNoMoreInteractions(context.mocks.hiveTestCollection);
      });
    });
  });
}
