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
        final id = await dataSource.putObject(testEntity);

        // act
        await Future.delayed(const Duration(seconds: 1));
        final result = await dataSource.getObject(id);

        // assert
        expect(result, testEntity);
      });

      test('should throw exception when object does not exist in the database',
          () async {
        // arrange
        const id = 1;

        // act & assert
        expect(
          () async => await dataSource.getObject(id),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getOptionObject', () {
      test('should return some option when object exists in the database',
          () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        final id = await dataSource.putObject(testEntity);

        // act
        final result = await dataSource.getOptionObject(id);

        // assert
        expect(result, some(testEntity));
      });

      test(
          'should return none option when object does not exist in the database',
          () async {
        // arrange
        const id = 1;

        // act
        final result = await dataSource.getOptionObject(id);

        // assert
        expect(result, none());
      });
    });

    group('getObjects', () {
      test('should return all objects with the given ids', () async {
        // arrange
        const testEntity1 = TestEntity(id: 1, name: 'Test1');
        const testEntity2 = TestEntity(id: 2, name: 'Test2');
        final id1 = await dataSource.putObject(testEntity1);
        final id2 = await dataSource.putObject(testEntity2);

        // act
        final result = await dataSource.getObjects([id1, id2]);

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
        final id = await dataSource.putObject(testEntity);

        // assert
        expect(id, isA<Id>());
        final retrievedObject = await dataSource.getObject(id);
        expect(retrievedObject, testEntity.copyWith(id: id));
      });
    });

    group('deleteObject', () {
      test('should delete object from the database', () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        final id = await dataSource.putObject(testEntity);

        // act
        await dataSource.deleteObject(id);
        final result = await dataSource.getOptionObject(id);

        // assert
        expect(result, none());
      });
    });

    group('streamObject', () {
      test('should stream updates for a specific object', () async {
        // arrange
        const testEntity = TestEntity(id: 1, name: 'Test');
        const updatedEntity = TestEntity(id: 1, name: 'Updated');
        final id = await dataSource.putObject(testEntity);
        dataSource.streamObject(id).listen(expectAsync1((value) {
          expect(value, updatedEntity);
        }));

        // act
        await dataSource.putObject(updatedEntity);
      });
    });

    group('streamObjects', () {
      test('should stream updates for a list of objects', () async {
        // arrange
        const testEntity1 = TestEntity(id: 1, name: 'Test1');
        const testEntity2 = TestEntity(id: 2, name: 'Test2');
        const updatedEntity1 = TestEntity(id: 1, name: 'Updated1');
        final id1 = await dataSource.putObject(testEntity1);
        final id2 = await dataSource.putObject(testEntity2);
        dataSource.streamObjects([id1, id2]).listen(expectAsync1((value) {
          expect(value, [updatedEntity1, testEntity2]);
        }));

        // act
        await dataSource.putObject(updatedEntity1);
      });
    });
  });
}
