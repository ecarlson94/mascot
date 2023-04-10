// Mocks generated by Mockito 5.3.2 from annotations
// in mascot/test/fixtures/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:dartz/dartz.dart' as _i4;
import 'package:idb_shim/idb_client.dart' as _i5;
import 'package:mascot/core/clean_architecture/usecase.dart' as _i24;
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart' as _i2;
import 'package:mascot/core/error/failure.dart' as _i13;
import 'package:mascot/core/utils/logger.dart' as _i26;
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i10;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i3;
import 'package:mascot/features/expressions/domain/entities/expression.dart'
    as _i14;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i12;
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i16;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i7;
import 'package:mascot/features/mascot/domain/entities/mascot.dart' as _i17;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i9;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i19;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i20;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i25;
import 'package:mascot/features/microphone/device/microphone.dart' as _i28;
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart'
    as _i22;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i27;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i29;
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i15;
import 'package:mascot/features/settings/data/models/settings_model.dart'
    as _i6;
import 'package:mascot/features/settings/domain/entities/settings.dart' as _i21;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i8;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i23;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i18;

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

class _FakeIndexedDbFactory_0 extends _i1.SmartFake
    implements _i2.IndexedDbFactory {
  _FakeIndexedDbFactory_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExpressionModel_1 extends _i1.SmartFake
    implements _i3.ExpressionModel {
  _FakeExpressionModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOption_2<A> extends _i1.SmartFake implements _i4.Option<A> {
  _FakeOption_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabase_3 extends _i1.SmartFake implements _i5.Database {
  _FakeDatabase_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_4<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsModel_5 extends _i1.SmartFake implements _i6.SettingsModel {
  _FakeSettingsModel_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotModel_6 extends _i1.SmartFake implements _i7.MascotModel {
  _FakeMascotModel_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsRepository_7 extends _i1.SmartFake
    implements _i8.SettingsRepository {
  _FakeSettingsRepository_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotsRepository_8 extends _i1.SmartFake
    implements _i9.MascotsRepository {
  _FakeMascotsRepository_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ExpressionsIndexedDbDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpressionsIndexedDbDataSource extends _i1.Mock
    implements _i10.ExpressionsIndexedDbDataSource {
  MockExpressionsIndexedDbDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IndexedDbFactory get indexedDbFactory => (super.noSuchMethod(
        Invocation.getter(#indexedDbFactory),
        returnValue: _FakeIndexedDbFactory_0(
          this,
          Invocation.getter(#indexedDbFactory),
        ),
      ) as _i2.IndexedDbFactory);
  @override
  String get storeName => (super.noSuchMethod(
        Invocation.getter(#storeName),
        returnValue: '',
      ) as String);
  @override
  _i3.ExpressionModel fromJson(Map<String, dynamic>? json) =>
      (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeExpressionModel_1(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i3.ExpressionModel);
  @override
  Map<String, dynamic> toJson(_i3.ExpressionModel? object) =>
      (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [object],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i11.Future<_i3.ExpressionModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue:
            _i11.Future<_i3.ExpressionModel>.value(_FakeExpressionModel_1(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i3.ExpressionModel>);
  @override
  _i11.Future<_i4.Option<_i3.ExpressionModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _i11.Future<_i4.Option<_i3.ExpressionModel>>.value(
            _FakeOption_2<_i3.ExpressionModel>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i4.Option<_i3.ExpressionModel>>);
  @override
  _i11.Future<List<_i3.ExpressionModel>> getObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue: _i11.Future<List<_i3.ExpressionModel>>.value(
            <_i3.ExpressionModel>[]),
      ) as _i11.Future<List<_i3.ExpressionModel>>);
  @override
  _i11.Future<int> putObject(_i3.ExpressionModel? object) =>
      (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _i11.Future<int>.value(0),
      ) as _i11.Future<int>);
  @override
  _i11.Future<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Stream<_i3.ExpressionModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i11.Stream<_i3.ExpressionModel>.empty(),
      ) as _i11.Stream<_i3.ExpressionModel>);
  @override
  _i11.Stream<List<_i3.ExpressionModel>> streamObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i11.Stream<List<_i3.ExpressionModel>>.empty(),
      ) as _i11.Stream<List<_i3.ExpressionModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i5.Database> openDb() => (super.noSuchMethod(
        Invocation.method(
          #openDb,
          [],
        ),
        returnValue: _i11.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #openDb,
            [],
          ),
        )),
      ) as _i11.Future<_i5.Database>);
}

/// A class which mocks [ExpressionsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpressionsRepository extends _i1.Mock
    implements _i12.ExpressionsRepository {
  MockExpressionsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, List<int>>> saveExpressions(
          Iterable<_i14.Expression>? expressions) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveExpressions,
          [expressions],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, List<int>>>.value(
            _FakeEither_4<_i13.Failure, List<int>>(
          this,
          Invocation.method(
            #saveExpressions,
            [expressions],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, List<int>>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, List<_i14.Expression>>> getExpressions(
          Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpressions,
          [ids],
        ),
        returnValue:
            _i11.Future<_i4.Either<_i13.Failure, List<_i14.Expression>>>.value(
                _FakeEither_4<_i13.Failure, List<_i14.Expression>>(
          this,
          Invocation.method(
            #getExpressions,
            [ids],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, List<_i14.Expression>>>);
}

/// A class which mocks [SettingsIndexedDbDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsIndexedDbDataSource extends _i1.Mock
    implements _i15.SettingsIndexedDbDataSource {
  MockSettingsIndexedDbDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IndexedDbFactory get indexedDbFactory => (super.noSuchMethod(
        Invocation.getter(#indexedDbFactory),
        returnValue: _FakeIndexedDbFactory_0(
          this,
          Invocation.getter(#indexedDbFactory),
        ),
      ) as _i2.IndexedDbFactory);
  @override
  String get storeName => (super.noSuchMethod(
        Invocation.getter(#storeName),
        returnValue: '',
      ) as String);
  @override
  _i11.Future<_i6.SettingsModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue: _i11.Future<_i6.SettingsModel>.value(_FakeSettingsModel_5(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i6.SettingsModel>);
  @override
  _i6.SettingsModel fromJson(Map<String, dynamic>? json) => (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeSettingsModel_5(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i6.SettingsModel);
  @override
  Map<String, dynamic> toJson(_i6.SettingsModel? object) => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [object],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i11.Future<_i4.Option<_i6.SettingsModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _i11.Future<_i4.Option<_i6.SettingsModel>>.value(
            _FakeOption_2<_i6.SettingsModel>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i4.Option<_i6.SettingsModel>>);
  @override
  _i11.Future<List<_i6.SettingsModel>> getObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue:
            _i11.Future<List<_i6.SettingsModel>>.value(<_i6.SettingsModel>[]),
      ) as _i11.Future<List<_i6.SettingsModel>>);
  @override
  _i11.Future<int> putObject(_i6.SettingsModel? object) => (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _i11.Future<int>.value(0),
      ) as _i11.Future<int>);
  @override
  _i11.Future<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Stream<_i6.SettingsModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i11.Stream<_i6.SettingsModel>.empty(),
      ) as _i11.Stream<_i6.SettingsModel>);
  @override
  _i11.Stream<List<_i6.SettingsModel>> streamObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i11.Stream<List<_i6.SettingsModel>>.empty(),
      ) as _i11.Stream<List<_i6.SettingsModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i5.Database> openDb() => (super.noSuchMethod(
        Invocation.method(
          #openDb,
          [],
        ),
        returnValue: _i11.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #openDb,
            [],
          ),
        )),
      ) as _i11.Future<_i5.Database>);
}

/// A class which mocks [MascotsIndexedDbDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsIndexedDbDataSource extends _i1.Mock
    implements _i16.MascotsIndexedDbDataSource {
  MockMascotsIndexedDbDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IndexedDbFactory get indexedDbFactory => (super.noSuchMethod(
        Invocation.getter(#indexedDbFactory),
        returnValue: _FakeIndexedDbFactory_0(
          this,
          Invocation.getter(#indexedDbFactory),
        ),
      ) as _i2.IndexedDbFactory);
  @override
  String get storeName => (super.noSuchMethod(
        Invocation.getter(#storeName),
        returnValue: '',
      ) as String);
  @override
  _i7.MascotModel fromJson(Map<String, dynamic>? json) => (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeMascotModel_6(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i7.MascotModel);
  @override
  Map<String, dynamic> toJson(_i7.MascotModel? object) => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [object],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i11.Future<_i7.MascotModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue: _i11.Future<_i7.MascotModel>.value(_FakeMascotModel_6(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i7.MascotModel>);
  @override
  _i11.Future<_i4.Option<_i7.MascotModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _i11.Future<_i4.Option<_i7.MascotModel>>.value(
            _FakeOption_2<_i7.MascotModel>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        )),
      ) as _i11.Future<_i4.Option<_i7.MascotModel>>);
  @override
  _i11.Future<List<_i7.MascotModel>> getObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue:
            _i11.Future<List<_i7.MascotModel>>.value(<_i7.MascotModel>[]),
      ) as _i11.Future<List<_i7.MascotModel>>);
  @override
  _i11.Future<int> putObject(_i7.MascotModel? object) => (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _i11.Future<int>.value(0),
      ) as _i11.Future<int>);
  @override
  _i11.Future<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Stream<_i7.MascotModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i11.Stream<_i7.MascotModel>.empty(),
      ) as _i11.Stream<_i7.MascotModel>);
  @override
  _i11.Stream<List<_i7.MascotModel>> streamObjects(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i11.Stream<List<_i7.MascotModel>>.empty(),
      ) as _i11.Stream<List<_i7.MascotModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i5.Database> openDb() => (super.noSuchMethod(
        Invocation.method(
          #openDb,
          [],
        ),
        returnValue: _i11.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #openDb,
            [],
          ),
        )),
      ) as _i11.Future<_i5.Database>);
}

/// A class which mocks [MascotsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsRepository extends _i1.Mock implements _i9.MascotsRepository {
  MockMascotsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, int>> saveMascot(_i17.Mascot? mascot) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveMascot,
          [mascot],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, int>>.value(
            _FakeEither_4<_i13.Failure, int>(
          this,
          Invocation.method(
            #saveMascot,
            [mascot],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, int>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>> getMascot(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>.value(
            _FakeEither_4<_i13.Failure, _i17.Mascot>(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>>
      streamMascot(int? id) => (super.noSuchMethod(
            Invocation.method(
              #streamMascot,
              [id],
            ),
            returnValue: _i11.Future<
                    _i4.Either<_i13.Failure,
                        _i18.BehaviorSubject<_i17.Mascot>>>.value(
                _FakeEither_4<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>(
              this,
              Invocation.method(
                #streamMascot,
                [id],
              ),
            )),
          ) as _i11.Future<
              _i4.Either<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>>);
}

/// A class which mocks [AddMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddMascot extends _i1.Mock implements _i19.AddMascot {
  MockAddMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>> call(
          _i17.Mascot? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>.value(
            _FakeEither_4<_i13.Failure, _i17.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>);
}

/// A class which mocks [GetMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMascot extends _i1.Mock implements _i20.GetMascot {
  MockGetMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>> call(int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>.value(
            _FakeEither_4<_i13.Failure, _i17.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i17.Mascot>>);
}

/// A class which mocks [SettingsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRepository extends _i1.Mock
    implements _i8.SettingsRepository {
  MockSettingsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, _i21.Settings>> loadSettings() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i21.Settings>>.value(
            _FakeEither_4<_i13.Failure, _i21.Settings>(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i21.Settings>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i18.BehaviorSubject<_i21.Settings>>>
      streamSettings() => (super.noSuchMethod(
            Invocation.method(
              #streamSettings,
              [],
            ),
            returnValue: _i11.Future<
                _i4.Either<_i13.Failure,
                    _i18.BehaviorSubject<_i21.Settings>>>.value(_FakeEither_4<
                _i13.Failure, _i18.BehaviorSubject<_i21.Settings>>(
              this,
              Invocation.method(
                #streamSettings,
                [],
              ),
            )),
          ) as _i11.Future<
              _i4.Either<_i13.Failure, _i18.BehaviorSubject<_i21.Settings>>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>> setFavoriteMascotId(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFavoriteMascotId,
          [id],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>>.value(
            _FakeEither_4<_i13.Failure, _i4.Unit>(
          this,
          Invocation.method(
            #setFavoriteMascotId,
            [id],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>>);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>> setTalkingThreshold(
          _i22.DecibelLufs? threshold) =>
      (super.noSuchMethod(
        Invocation.method(
          #setTalkingThreshold,
          [threshold],
        ),
        returnValue: _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>>.value(
            _FakeEither_4<_i13.Failure, _i4.Unit>(
          this,
          Invocation.method(
            #setTalkingThreshold,
            [threshold],
          ),
        )),
      ) as _i11.Future<_i4.Either<_i13.Failure, _i4.Unit>>);
}

/// A class which mocks [StreamSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSettings extends _i1.Mock implements _i23.StreamSettings {
  MockStreamSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.SettingsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSettingsRepository_7(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i8.SettingsRepository);
  @override
  _i11.Future<
      _i4.Either<_i13.Failure, _i18.BehaviorSubject<_i21.Settings>>> call(
          _i24.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i11.Future<
                _i4.Either<_i13.Failure,
                    _i18.BehaviorSubject<_i21.Settings>>>.value(
            _FakeEither_4<_i13.Failure, _i18.BehaviorSubject<_i21.Settings>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i11.Future<
          _i4.Either<_i13.Failure, _i18.BehaviorSubject<_i21.Settings>>>);
}

/// A class which mocks [StreamMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMascot extends _i1.Mock implements _i25.StreamMascot {
  MockStreamMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.MascotsRepository get mascotsRepository => (super.noSuchMethod(
        Invocation.getter(#mascotsRepository),
        returnValue: _FakeMascotsRepository_8(
          this,
          Invocation.getter(#mascotsRepository),
        ),
      ) as _i9.MascotsRepository);
  @override
  _i11.Future<_i4.Either<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>> call(
          int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i11.Future<
                _i4.Either<_i13.Failure,
                    _i18.BehaviorSubject<_i17.Mascot>>>.value(
            _FakeEither_4<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i11
          .Future<_i4.Either<_i13.Failure, _i18.BehaviorSubject<_i17.Mascot>>>);
}

/// A class which mocks [Logger].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogger<T> extends _i1.Mock implements _i26.Logger<T> {
  MockLogger() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void log(String? message) => super.noSuchMethod(
        Invocation.method(
          #log,
          [message],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void logError(
    String? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #logError,
          [
            message,
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void logWarning(String? message) => super.noSuchMethod(
        Invocation.method(
          #logWarning,
          [message],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MicrophoneService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMicrophoneService extends _i1.Mock implements _i27.MicrophoneService {
  MockMicrophoneService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>>
      getVolumeStream() => (super.noSuchMethod(
            Invocation.method(
              #getVolumeStream,
              [],
            ),
            returnValue: _i11.Future<
                    _i4.Either<_i13.Failure,
                        _i11.Stream<_i22.DecibelLufs>>>.value(
                _FakeEither_4<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>(
              this,
              Invocation.method(
                #getVolumeStream,
                [],
              ),
            )),
          ) as _i11
              .Future<_i4.Either<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>>);
}

/// A class which mocks [Microphone].
///
/// See the documentation for Mockito's code generation for more information.
class MockMicrophone extends _i1.Mock implements _i28.Microphone {
  MockMicrophone() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Stream<_i22.DecibelLufs> get volumeStream => (super.noSuchMethod(
        Invocation.getter(#volumeStream),
        returnValue: _i11.Stream<_i22.DecibelLufs>.empty(),
      ) as _i11.Stream<_i22.DecibelLufs>);
  @override
  _i11.Future<bool> hasPermission() => (super.noSuchMethod(
        Invocation.method(
          #hasPermission,
          [],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);
}

/// A class which mocks [StreamMicrophoneVolume].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMicrophoneVolume extends _i1.Mock
    implements _i29.StreamMicrophoneVolume {
  MockStreamMicrophoneVolume() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i4.Either<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>> call(
          _i24.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i11.Future<
                _i4.Either<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>>.value(
            _FakeEither_4<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i11
          .Future<_i4.Either<_i13.Failure, _i11.Stream<_i22.DecibelLufs>>>);
}
