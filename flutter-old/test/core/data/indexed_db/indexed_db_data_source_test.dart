import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_client_memory.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart';

import '../../../fixtures/test_model.dart';

class TestIndexedDbDataSource extends IndexedDbDataSourceImpl<TestEntity> {
  TestIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  TestEntity fromJson(Map<String, dynamic> json) {
    return TestEntity(id: json['id'] as Id, name: json['name'] as String);
  }

  @override
  Map<String, dynamic> toJson(TestEntity object) {
    return {'id': object.id, 'name': object.name};
  }
}

class TestIdbFactory extends IndexedDbFactory {
  @override
  IdbFactory? get factory => idbFactoryMemory;
}

void main() {
  IndexDbSettings settings = IndexDbSettings();
  late TestIdbFactory indexedDbFactory;
  late TestIndexedDbDataSource dataSource;

  setUp(() async {
    indexedDbFactory = TestIdbFactory();
    dataSource = TestIndexedDbDataSource(indexedDbFactory, settings);
    Type testType = TestEntity;
    await indexedDbFactory.factory!.deleteDatabase(testType.toString());
  });

  group('IndexedDbDataSourceImpl', () {
    group('getObject', () {
      test('should return object when object exists in the database', () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        final id = await dataSource.putObject(testEntity).single;

        // act
        final result = await dataSource.getObject(id).single;

        // assert
        expect(result, testEntity);
      });

      test('should throw exception when object does not exist in the database',
          () async {
        // arrange
        const id = 1;

        // act & assert
        expect(
          () async => await dataSource.getObject(id).single,
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getOptionObject', () {
      test('should return some option when object exists in the database',
          () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        final id = await dataSource.putObject(testEntity).single;

        // act
        final result = await dataSource.getOptionObject(id).single;

        // assert
        expect(result, some(testEntity));
      });

      test(
          'should return none option when object does not exist in the database',
          () async {
        // arrange
        const id = 1;

        // act
        final result = await dataSource.getOptionObject(id).single;

        // assert
        expect(result, none());
      });
    });

    group('getObjects', () {
      test('should return all objects with the given ids', () async {
        // arrange
        const testEntity1 = TestEntity(id: 1, name: 'Test1');
        const testEntity2 = TestEntity(id: 2, name: 'Test2');
        final id1 = await dataSource.putObject(testEntity1).single;
        final id2 = await dataSource.putObject(testEntity2).single;

        // act
        final result = await dataSource.getObjects([id1, id2]).single;

        // assert
        expect(result, [testEntity1, testEntity2]);
      });
    });

    group('putObject', () {
      test('should save object to the database and return the object id',
          () async {
        // arrange
        const testEntity = TestEntity(id: 0, name: 'Test');

        // act
        final id = await dataSource.putObject(testEntity).single;

        // assert
        expect(id, isA<Id>());
        final retrievedObject = await dataSource.getObject(id).single;
        expect(retrievedObject, testEntity.copyWith(id: id));
      });
    });

    group('deleteObject', () {
      test('should delete object from the database', () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        final id = await dataSource.putObject(testEntity).single;

        // act
        await dataSource.deleteObject(id).single;
        final result = await dataSource.getOptionObject(id).single;

        // assert
        expect(result, none());
      });
    });

    group('streamObject', () {
      test('should stream updates for a specific object', () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        const entityToUpdate = TestEntity(id: 1, name: 'Updated');
        final id = await dataSource.putObject(testEntity).single;

        late TestEntity result;
        dataSource.streamObject(id).listen((value) => result = value);

        // act
        await dataSource.putObject(entityToUpdate).single;

        // assert
        await expectLater(result, entityToUpdate);
      });
    });

    group('streamObjects', () {
      test('should seed stream with current values', () async {
        // arrange
        const testEntity1 = TestEntity(id: 1, name: 'Test1');
        const testEntity2 = TestEntity(id: 2, name: 'Test2');
        final id1 = await dataSource.putObject(testEntity1).single;
        final id2 = await dataSource.putObject(testEntity2).single;
        var stream = dataSource.streamObjects([id1, id2]);

        // assert
        expect(
          stream,
          emitsInOrder([
            [testEntity1, testEntity2],
          ]),
        );
      });

      test('should stream updates for a list of objects', () async {
        // arrange
        const testEntity1 = TestEntity(id: 1, name: 'Test1');
        const testEntity2 = TestEntity(id: 2, name: 'Test2');
        const updatedEntity1 = TestEntity(id: 1, name: 'Updated1');
        final id1 = await dataSource.putObject(testEntity1).single;
        final id2 = await dataSource.putObject(testEntity2).single;
        var stream = dataSource.streamObjects([id1, id2]);

        // act
        await dataSource.putObject(updatedEntity1).single;

        // assert
        expect(
          stream,
          emitsInOrder([
            [updatedEntity1, testEntity2],
          ]),
        );
      });
    });
  });
}
