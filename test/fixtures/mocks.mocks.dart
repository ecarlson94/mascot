// Mocks generated by Mockito 5.3.2 from annotations
// in mascot/test/fixtures/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i11;

import 'package:dartz/dartz.dart' as _i2;
import 'package:hive/hive.dart' as _i5;
import 'package:image_picker/image_picker.dart' as _i14;
import 'package:isar/isar.dart' as _i4;
import 'package:mascot/core/error/failure.dart' as _i8;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i13;
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart'
    as _i15;
import 'package:mascot/features/images/data/datasources/images_collection.dart'
    as _i12;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i10;
import 'package:mascot/features/images/data/models/image_model.dart' as _i3;
import 'package:mascot/features/images/domain/entities/image.dart' as _i9;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i6;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i16;
import 'package:mascot/features/images/domain/usecases/save_image.dart' as _i17;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeImageModel_1 extends _i1.SmartFake implements _i3.ImageModel {
  _FakeImageModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIsar_2 extends _i1.SmartFake implements _i4.Isar {
  _FakeIsar_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCollectionSchema_3<OBJ> extends _i1.SmartFake
    implements _i4.CollectionSchema<OBJ> {
  _FakeCollectionSchema_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQueryBuilder_4<OBJ, R, S> extends _i1.SmartFake
    implements _i4.QueryBuilder<OBJ, R, S> {
  _FakeQueryBuilder_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuery_5<T> extends _i1.SmartFake implements _i4.Query<T> {
  _FakeQuery_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBoxCollection_6 extends _i1.SmartFake implements _i5.BoxCollection {
  _FakeBoxCollection_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCollectionBox_7<V> extends _i1.SmartFake
    implements _i5.CollectionBox<V> {
  _FakeCollectionBox_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ImagesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagesRepository extends _i1.Mock implements _i6.ImagesRepository {
  MockImagesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.Image>> saveImage(_i9.Image? image) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveImage,
          [image],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>.value(
            _FakeEither_0<_i8.Failure, _i9.Image>(
          this,
          Invocation.method(
            #saveImage,
            [image],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.Image>> getImage(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [id],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>.value(
            _FakeEither_0<_i8.Failure, _i9.Image>(
          this,
          Invocation.method(
            #getImage,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>);
}

/// A class which mocks [ImagesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagesLocalDataSource extends _i1.Mock
    implements _i10.ImagesLocalDataSource {
  MockImagesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i3.ImageModel> saveImage(_i3.ImageModel? image) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveImage,
          [image],
        ),
        returnValue: _i7.Future<_i3.ImageModel>.value(_FakeImageModel_1(
          this,
          Invocation.method(
            #saveImage,
            [image],
          ),
        )),
      ) as _i7.Future<_i3.ImageModel>);
  @override
  _i7.Future<_i3.ImageModel> getImage(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [id],
        ),
        returnValue: _i7.Future<_i3.ImageModel>.value(_FakeImageModel_1(
          this,
          Invocation.method(
            #getImage,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.ImageModel>);
}

/// A class which mocks [IsarCollection].
///
/// See the documentation for Mockito's code generation for more information.
class MockIsarCollection<OBJ> extends _i1.Mock
    implements _i4.IsarCollection<OBJ> {
  MockIsarCollection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Isar get isar => (super.noSuchMethod(
        Invocation.getter(#isar),
        returnValue: _FakeIsar_2(
          this,
          Invocation.getter(#isar),
        ),
      ) as _i4.Isar);
  @override
  _i4.CollectionSchema<OBJ> get schema => (super.noSuchMethod(
        Invocation.getter(#schema),
        returnValue: _FakeCollectionSchema_3<OBJ>(
          this,
          Invocation.getter(#schema),
        ),
      ) as _i4.CollectionSchema<OBJ>);
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: '',
      ) as String);
  @override
  _i7.Future<OBJ?> get(int? id) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i7.Future<OBJ?>.value(),
      ) as _i7.Future<OBJ?>);
  @override
  OBJ? getSync(int? id) => (super.noSuchMethod(Invocation.method(
        #getSync,
        [id],
      )) as OBJ?);
  @override
  _i7.Future<List<OBJ?>> getAll(List<int>? ids) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [ids],
        ),
        returnValue: _i7.Future<List<OBJ?>>.value(<OBJ?>[]),
      ) as _i7.Future<List<OBJ?>>);
  @override
  List<OBJ?> getAllSync(List<int>? ids) => (super.noSuchMethod(
        Invocation.method(
          #getAllSync,
          [ids],
        ),
        returnValue: <OBJ?>[],
      ) as List<OBJ?>);
  @override
  _i7.Future<OBJ?> getByIndex(
    String? indexName,
    List<Object?>? key,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getByIndex,
          [
            indexName,
            key,
          ],
        ),
        returnValue: _i7.Future<OBJ?>.value(),
      ) as _i7.Future<OBJ?>);
  @override
  OBJ? getByIndexSync(
    String? indexName,
    List<Object?>? key,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #getByIndexSync,
        [
          indexName,
          key,
        ],
      )) as OBJ?);
  @override
  _i7.Future<List<OBJ?>> getAllByIndex(
    String? indexName,
    List<List<Object?>>? keys,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllByIndex,
          [
            indexName,
            keys,
          ],
        ),
        returnValue: _i7.Future<List<OBJ?>>.value(<OBJ?>[]),
      ) as _i7.Future<List<OBJ?>>);
  @override
  List<OBJ?> getAllByIndexSync(
    String? indexName,
    List<List<Object?>>? keys,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllByIndexSync,
          [
            indexName,
            keys,
          ],
        ),
        returnValue: <OBJ?>[],
      ) as List<OBJ?>);
  @override
  _i7.Future<int> put(OBJ? object) => (super.noSuchMethod(
        Invocation.method(
          #put,
          [object],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int putSync(
    OBJ? object, {
    bool? saveLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putSync,
          [object],
          {#saveLinks: saveLinks},
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Future<List<int>> putAll(List<OBJ>? objects) => (super.noSuchMethod(
        Invocation.method(
          #putAll,
          [objects],
        ),
        returnValue: _i7.Future<List<int>>.value(<int>[]),
      ) as _i7.Future<List<int>>);
  @override
  List<int> putAllSync(
    List<OBJ>? objects, {
    bool? saveLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAllSync,
          [objects],
          {#saveLinks: saveLinks},
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  _i7.Future<int> putByIndex(
    String? indexName,
    OBJ? object,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putByIndex,
          [
            indexName,
            object,
          ],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int putByIndexSync(
    String? indexName,
    OBJ? object, {
    bool? saveLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putByIndexSync,
          [
            indexName,
            object,
          ],
          {#saveLinks: saveLinks},
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Future<List<int>> putAllByIndex(
    String? indexName,
    List<OBJ>? objects,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAllByIndex,
          [
            indexName,
            objects,
          ],
        ),
        returnValue: _i7.Future<List<int>>.value(<int>[]),
      ) as _i7.Future<List<int>>);
  @override
  List<int> putAllByIndexSync(
    String? indexName,
    List<OBJ>? objects, {
    bool? saveLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAllByIndexSync,
          [
            indexName,
            objects,
          ],
          {#saveLinks: saveLinks},
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  _i7.Future<bool> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  bool deleteSync(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteSync,
          [id],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i7.Future<int> deleteAll(List<int>? ids) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [ids],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int deleteAllSync(List<int>? ids) => (super.noSuchMethod(
        Invocation.method(
          #deleteAllSync,
          [ids],
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Future<bool> deleteByIndex(
    String? indexName,
    List<Object?>? key,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteByIndex,
          [
            indexName,
            key,
          ],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  bool deleteByIndexSync(
    String? indexName,
    List<Object?>? key,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteByIndexSync,
          [
            indexName,
            key,
          ],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i7.Future<int> deleteAllByIndex(
    String? indexName,
    List<List<Object?>>? keys,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAllByIndex,
          [
            indexName,
            keys,
          ],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int deleteAllByIndexSync(
    String? indexName,
    List<List<Object?>>? keys,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAllByIndexSync,
          [
            indexName,
            keys,
          ],
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void clearSync() => super.noSuchMethod(
        Invocation.method(
          #clearSync,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<void> importJsonRaw(_i11.Uint8List? jsonBytes) =>
      (super.noSuchMethod(
        Invocation.method(
          #importJsonRaw,
          [jsonBytes],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void importJsonRawSync(_i11.Uint8List? jsonBytes) => super.noSuchMethod(
        Invocation.method(
          #importJsonRawSync,
          [jsonBytes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<void> importJson(List<Map<String, dynamic>>? json) =>
      (super.noSuchMethod(
        Invocation.method(
          #importJson,
          [json],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void importJsonSync(List<Map<String, dynamic>>? json) => super.noSuchMethod(
        Invocation.method(
          #importJsonSync,
          [json],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.QueryBuilder<OBJ, OBJ, _i4.QWhere> where({
    bool? distinct = false,
    _i4.Sort? sort = _i4.Sort.asc,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #where,
          [],
          {
            #distinct: distinct,
            #sort: sort,
          },
        ),
        returnValue: _FakeQueryBuilder_4<OBJ, OBJ, _i4.QWhere>(
          this,
          Invocation.method(
            #where,
            [],
            {
              #distinct: distinct,
              #sort: sort,
            },
          ),
        ),
      ) as _i4.QueryBuilder<OBJ, OBJ, _i4.QWhere>);
  @override
  _i4.QueryBuilder<OBJ, OBJ, _i4.QFilterCondition> filter() =>
      (super.noSuchMethod(
        Invocation.method(
          #filter,
          [],
        ),
        returnValue: _FakeQueryBuilder_4<OBJ, OBJ, _i4.QFilterCondition>(
          this,
          Invocation.method(
            #filter,
            [],
          ),
        ),
      ) as _i4.QueryBuilder<OBJ, OBJ, _i4.QFilterCondition>);
  @override
  _i4.Query<R> buildQuery<R>({
    List<_i4.WhereClause>? whereClauses = const [],
    bool? whereDistinct = false,
    _i4.Sort? whereSort = _i4.Sort.asc,
    _i4.FilterOperation? filter,
    List<_i4.SortProperty>? sortBy = const [],
    List<_i4.DistinctProperty>? distinctBy = const [],
    int? offset,
    int? limit,
    String? property,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #buildQuery,
          [],
          {
            #whereClauses: whereClauses,
            #whereDistinct: whereDistinct,
            #whereSort: whereSort,
            #filter: filter,
            #sortBy: sortBy,
            #distinctBy: distinctBy,
            #offset: offset,
            #limit: limit,
            #property: property,
          },
        ),
        returnValue: _FakeQuery_5<R>(
          this,
          Invocation.method(
            #buildQuery,
            [],
            {
              #whereClauses: whereClauses,
              #whereDistinct: whereDistinct,
              #whereSort: whereSort,
              #filter: filter,
              #sortBy: sortBy,
              #distinctBy: distinctBy,
              #offset: offset,
              #limit: limit,
              #property: property,
            },
          ),
        ),
      ) as _i4.Query<R>);
  @override
  _i7.Future<int> count() => (super.noSuchMethod(
        Invocation.method(
          #count,
          [],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int countSync() => (super.noSuchMethod(
        Invocation.method(
          #countSync,
          [],
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Future<int> getSize({
    bool? includeIndexes = false,
    bool? includeLinks = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSize,
          [],
          {
            #includeIndexes: includeIndexes,
            #includeLinks: includeLinks,
          },
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  int getSizeSync({
    bool? includeIndexes = false,
    bool? includeLinks = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSizeSync,
          [],
          {
            #includeIndexes: includeIndexes,
            #includeLinks: includeLinks,
          },
        ),
        returnValue: 0,
      ) as int);
  @override
  _i7.Stream<void> watchLazy({bool? fireImmediately = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #watchLazy,
          [],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: _i7.Stream<void>.empty(),
      ) as _i7.Stream<void>);
  @override
  _i7.Stream<OBJ?> watchObject(
    int? id, {
    bool? fireImmediately = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #watchObject,
          [id],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: _i7.Stream<OBJ?>.empty(),
      ) as _i7.Stream<OBJ?>);
  @override
  _i7.Stream<void> watchObjectLazy(
    int? id, {
    bool? fireImmediately = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #watchObjectLazy,
          [id],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: _i7.Stream<void>.empty(),
      ) as _i7.Stream<void>);
  @override
  _i7.Future<void> verify(List<OBJ>? objects) => (super.noSuchMethod(
        Invocation.method(
          #verify,
          [objects],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> verifyLink(
    String? linkName,
    List<int>? sourceIds,
    List<int>? targetIds,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyLink,
          [
            linkName,
            sourceIds,
            targetIds,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [CollectionBox].
///
/// See the documentation for Mockito's code generation for more information.
class MockCollectionBox<V> extends _i1.Mock implements _i5.CollectionBox<V> {
  MockCollectionBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: '',
      ) as String);
  @override
  _i5.BoxCollection get boxCollection => (super.noSuchMethod(
        Invocation.getter(#boxCollection),
        returnValue: _FakeBoxCollection_6(
          this,
          Invocation.getter(#boxCollection),
        ),
      ) as _i5.BoxCollection);
  @override
  _i7.Future<List<String>> getAllKeys() => (super.noSuchMethod(
        Invocation.method(
          #getAllKeys,
          [],
        ),
        returnValue: _i7.Future<List<String>>.value(<String>[]),
      ) as _i7.Future<List<String>>);
  @override
  _i7.Future<Map<String, V>> getAllValues() => (super.noSuchMethod(
        Invocation.method(
          #getAllValues,
          [],
        ),
        returnValue: _i7.Future<Map<String, V>>.value(<String, V>{}),
      ) as _i7.Future<Map<String, V>>);
  @override
  _i7.Future<V?> get(String? key) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [key],
        ),
        returnValue: _i7.Future<V?>.value(),
      ) as _i7.Future<V?>);
  @override
  _i7.Future<List<V?>> getAll(List<String>? keys) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [keys],
        ),
        returnValue: _i7.Future<List<V?>>.value(<V?>[]),
      ) as _i7.Future<List<V?>>);
  @override
  _i7.Future<void> put(
    String? key,
    V? val, [
    Object? transaction,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            key,
            val,
            transaction,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> delete(String? key) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> deleteAll(List<String>? keys) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [keys],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [LocalImages].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalImages extends _i1.Mock implements _i12.LocalImages {
  MockLocalImages() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.CollectionBox<_i3.ImageModel> get collection => (super.noSuchMethod(
        Invocation.getter(#collection),
        returnValue: _FakeCollectionBox_7<_i3.ImageModel>(
          this,
          Invocation.getter(#collection),
        ),
      ) as _i5.CollectionBox<_i3.ImageModel>);
  @override
  _i7.Future<_i3.ImageModel> get(int? id) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i7.Future<_i3.ImageModel>.value(_FakeImageModel_1(
          this,
          Invocation.method(
            #get,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.ImageModel>);
  @override
  _i7.Future<_i3.ImageModel> save(_i3.ImageModel? item) => (super.noSuchMethod(
        Invocation.method(
          #save,
          [item],
        ),
        returnValue: _i7.Future<_i3.ImageModel>.value(_FakeImageModel_1(
          this,
          Invocation.method(
            #save,
            [item],
          ),
        )),
      ) as _i7.Future<_i3.ImageModel>);
}

/// A class which mocks [ConvertXfileToImage].
///
/// See the documentation for Mockito's code generation for more information.
class MockConvertXfileToImage extends _i1.Mock
    implements _i13.ConvertXfileToImage {
  MockConvertXfileToImage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i8.Failure, _i9.Image> call(_i14.XFile? input) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [input],
        ),
        returnValue: _FakeEither_0<_i8.Failure, _i9.Image>(
          this,
          Invocation.method(
            #call,
            [input],
          ),
        ),
      ) as _i2.Either<_i8.Failure, _i9.Image>);
}

/// A class which mocks [MapImageToImageModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockMapImageToImageModel extends _i1.Mock
    implements _i15.MapImageToImageModel {
  MockMapImageToImageModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.ImageModel call(_i9.Image? input) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [input],
        ),
        returnValue: _FakeImageModel_1(
          this,
          Invocation.method(
            #call,
            [input],
          ),
        ),
      ) as _i3.ImageModel);
}

/// A class which mocks [GetImage].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetImage extends _i1.Mock implements _i16.GetImage {
  MockGetImage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.Image>> call(int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>.value(
            _FakeEither_0<_i8.Failure, _i9.Image>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>);
}

/// A class which mocks [SaveImage].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveImage extends _i1.Mock implements _i17.SaveImage {
  MockSaveImage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.Image>> call(_i9.Image? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>.value(
            _FakeEither_0<_i8.Failure, _i9.Image>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.Image>>);
}
