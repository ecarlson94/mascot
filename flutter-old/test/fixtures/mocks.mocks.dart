// Mocks generated by Mockito 5.4.0 from annotations
// in mascot/test/fixtures/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:dartz/dartz.dart' as _i11;
import 'package:flutter_bloc/flutter_bloc.dart' as _i33;
import 'package:mascot/core/clean_architecture/usecase.dart' as _i25;
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart' as _i2;
import 'package:mascot/core/reactive/base_bloc.dart' as _i19;
import 'package:mascot/core/utils/logger.dart' as _i28;
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i10;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i3;
import 'package:mascot/features/expressions/domain/entities/expression.dart'
    as _i13;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i12;
import 'package:mascot/features/expressions/domain/services/animation/expression_animation_service.dart'
    as _i32;
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i15;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i6;
import 'package:mascot/features/mascot/domain/entities/mascot.dart' as _i16;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i8;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i17;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i21;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i27;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart'
    as _i20;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart'
    as _i18;
import 'package:mascot/features/microphone/device/microphone.dart' as _i30;
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart'
    as _i23;
import 'package:mascot/features/microphone/domain/services/microphone_context.dart'
    as _i29;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i31;
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i14;
import 'package:mascot/features/settings/data/models/settings_model.dart'
    as _i5;
import 'package:mascot/features/settings/domain/entities/settings.dart' as _i22;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i7;
import 'package:mascot/features/settings/domain/usecases/save_talking_threshold.dart'
    as _i26;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i24;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart_ext/rxdart_ext.dart' as _i4;

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

class _FakeSingle_2<T> extends _i1.SmartFake implements _i4.Single<T> {
  _FakeSingle_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsModel_3 extends _i1.SmartFake implements _i5.SettingsModel {
  _FakeSettingsModel_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotModel_4 extends _i1.SmartFake implements _i6.MascotModel {
  _FakeMascotModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsRepository_5 extends _i1.SmartFake
    implements _i7.SettingsRepository {
  _FakeSettingsRepository_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotsRepository_6 extends _i1.SmartFake
    implements _i8.MascotsRepository {
  _FakeMascotsRepository_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_7<T> extends _i1.SmartFake implements _i9.Future<T> {
  _FakeFuture_7(
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
  _i4.Single<_i3.ExpressionModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i3.ExpressionModel>(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i3.ExpressionModel>);
  @override
  _i4.Single<_i11.Option<_i3.ExpressionModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i11.Option<_i3.ExpressionModel>>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i11.Option<_i3.ExpressionModel>>);
  @override
  _i4.Single<List<_i3.ExpressionModel>> getObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue: _FakeSingle_2<List<_i3.ExpressionModel>>(
          this,
          Invocation.method(
            #getObjects,
            [ids],
          ),
        ),
      ) as _i4.Single<List<_i3.ExpressionModel>>);
  @override
  _i4.Single<int> putObject(_i3.ExpressionModel? object) => (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _FakeSingle_2<int>(
          this,
          Invocation.method(
            #putObject,
            [object],
          ),
        ),
      ) as _i4.Single<int>);
  @override
  _i4.Single<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _FakeSingle_2<void>(
          this,
          Invocation.method(
            #deleteObject,
            [id],
          ),
        ),
      ) as _i4.Single<void>);
  @override
  _i9.Stream<_i3.ExpressionModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i9.Stream<_i3.ExpressionModel>.empty(),
      ) as _i9.Stream<_i3.ExpressionModel>);
  @override
  _i9.Stream<List<_i3.ExpressionModel>> streamObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i9.Stream<List<_i3.ExpressionModel>>.empty(),
      ) as _i9.Stream<List<_i3.ExpressionModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
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
  _i4.Single<List<int>> saveExpressions(List<_i13.Expression>? expressions) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveExpressions,
          [expressions],
        ),
        returnValue: _FakeSingle_2<List<int>>(
          this,
          Invocation.method(
            #saveExpressions,
            [expressions],
          ),
        ),
      ) as _i4.Single<List<int>>);
  @override
  _i4.Single<List<_i13.Expression>> getExpressions(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpressions,
          [ids],
        ),
        returnValue: _FakeSingle_2<List<_i13.Expression>>(
          this,
          Invocation.method(
            #getExpressions,
            [ids],
          ),
        ),
      ) as _i4.Single<List<_i13.Expression>>);
}

/// A class which mocks [SettingsIndexedDbDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsIndexedDbDataSource extends _i1.Mock
    implements _i14.SettingsIndexedDbDataSource {
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
  _i4.Single<_i5.SettingsModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i5.SettingsModel>(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i5.SettingsModel>);
  @override
  _i5.SettingsModel fromJson(Map<String, dynamic>? json) => (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeSettingsModel_3(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i5.SettingsModel);
  @override
  Map<String, dynamic> toJson(_i5.SettingsModel? object) => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [object],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i4.Single<_i11.Option<_i5.SettingsModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i11.Option<_i5.SettingsModel>>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i11.Option<_i5.SettingsModel>>);
  @override
  _i4.Single<List<_i5.SettingsModel>> getObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue: _FakeSingle_2<List<_i5.SettingsModel>>(
          this,
          Invocation.method(
            #getObjects,
            [ids],
          ),
        ),
      ) as _i4.Single<List<_i5.SettingsModel>>);
  @override
  _i4.Single<int> putObject(_i5.SettingsModel? object) => (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _FakeSingle_2<int>(
          this,
          Invocation.method(
            #putObject,
            [object],
          ),
        ),
      ) as _i4.Single<int>);
  @override
  _i4.Single<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _FakeSingle_2<void>(
          this,
          Invocation.method(
            #deleteObject,
            [id],
          ),
        ),
      ) as _i4.Single<void>);
  @override
  _i9.Stream<_i5.SettingsModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i9.Stream<_i5.SettingsModel>.empty(),
      ) as _i9.Stream<_i5.SettingsModel>);
  @override
  _i9.Stream<List<_i5.SettingsModel>> streamObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i9.Stream<List<_i5.SettingsModel>>.empty(),
      ) as _i9.Stream<List<_i5.SettingsModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MascotsIndexedDbDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsIndexedDbDataSource extends _i1.Mock
    implements _i15.MascotsIndexedDbDataSource {
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
  _i6.MascotModel fromJson(Map<String, dynamic>? json) => (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeMascotModel_4(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i6.MascotModel);
  @override
  Map<String, dynamic> toJson(_i6.MascotModel? object) => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [object],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i4.Single<_i6.MascotModel> getObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i6.MascotModel>(
          this,
          Invocation.method(
            #getObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i6.MascotModel>);
  @override
  _i4.Single<_i11.Option<_i6.MascotModel>> getOptionObject(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOptionObject,
          [id],
        ),
        returnValue: _FakeSingle_2<_i11.Option<_i6.MascotModel>>(
          this,
          Invocation.method(
            #getOptionObject,
            [id],
          ),
        ),
      ) as _i4.Single<_i11.Option<_i6.MascotModel>>);
  @override
  _i4.Single<List<_i6.MascotModel>> getObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getObjects,
          [ids],
        ),
        returnValue: _FakeSingle_2<List<_i6.MascotModel>>(
          this,
          Invocation.method(
            #getObjects,
            [ids],
          ),
        ),
      ) as _i4.Single<List<_i6.MascotModel>>);
  @override
  _i4.Single<int> putObject(_i6.MascotModel? object) => (super.noSuchMethod(
        Invocation.method(
          #putObject,
          [object],
        ),
        returnValue: _FakeSingle_2<int>(
          this,
          Invocation.method(
            #putObject,
            [object],
          ),
        ),
      ) as _i4.Single<int>);
  @override
  _i4.Single<void> deleteObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteObject,
          [id],
        ),
        returnValue: _FakeSingle_2<void>(
          this,
          Invocation.method(
            #deleteObject,
            [id],
          ),
        ),
      ) as _i4.Single<void>);
  @override
  _i9.Stream<_i6.MascotModel> streamObject(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamObject,
          [id],
        ),
        returnValue: _i9.Stream<_i6.MascotModel>.empty(),
      ) as _i9.Stream<_i6.MascotModel>);
  @override
  _i9.Stream<List<_i6.MascotModel>> streamObjects(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamObjects,
          [ids],
        ),
        returnValue: _i9.Stream<List<_i6.MascotModel>>.empty(),
      ) as _i9.Stream<List<_i6.MascotModel>>);
  @override
  void onDispose() => super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MascotsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsRepository extends _i1.Mock implements _i8.MascotsRepository {
  MockMascotsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<int> saveMascot(_i16.Mascot? mascot) => (super.noSuchMethod(
        Invocation.method(
          #saveMascot,
          [mascot],
        ),
        returnValue: _FakeSingle_2<int>(
          this,
          Invocation.method(
            #saveMascot,
            [mascot],
          ),
        ),
      ) as _i4.Single<int>);
  @override
  _i4.Single<_i16.Mascot> getMascot(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _FakeSingle_2<_i16.Mascot>(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        ),
      ) as _i4.Single<_i16.Mascot>);
  @override
  _i9.Stream<_i16.Mascot> streamMascot(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamMascot,
          [id],
        ),
        returnValue: _i9.Stream<_i16.Mascot>.empty(),
      ) as _i9.Stream<_i16.Mascot>);
}

/// A class which mocks [AddMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddMascot extends _i1.Mock implements _i17.AddMascot {
  MockAddMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<_i16.Mascot> call(_i16.Mascot? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _FakeSingle_2<_i16.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        ),
      ) as _i4.Single<_i16.Mascot>);
}

/// A class which mocks [SaveMascotEffect].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveMascotEffect extends _i1.Mock implements _i18.SaveMascotEffect {
  MockSaveMascotEffect() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i19.EffectRepeatStrategy get repeatStrategy => (super.noSuchMethod(
        Invocation.getter(#repeatStrategy),
        returnValue: _i19.EffectRepeatStrategy.once,
      ) as _i19.EffectRepeatStrategy);
  @override
  _i19.EffectReplaceStrategy get replacementStrategy => (super.noSuchMethod(
        Invocation.getter(#replacementStrategy),
        returnValue: _i19.EffectReplaceStrategy.replace,
      ) as _i19.EffectReplaceStrategy);
  @override
  List<_i9.StreamSubscription<dynamic>> get subscriptions =>
      (super.noSuchMethod(
        Invocation.getter(#subscriptions),
        returnValue: <_i9.StreamSubscription<dynamic>>[],
      ) as List<_i9.StreamSubscription<dynamic>>);
  @override
  _i9.Stream<_i20.CreateMascotEvent> call(
    _i20.SaveMascotEvent? event,
    _i20.CreateMascotState? state,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            event,
            state,
          ],
        ),
        returnValue: _i9.Stream<_i20.CreateMascotEvent>.empty(),
      ) as _i9.Stream<_i20.CreateMascotEvent>);
}

/// A class which mocks [GetMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMascot extends _i1.Mock implements _i21.GetMascot {
  MockGetMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<_i16.Mascot> call(int? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _FakeSingle_2<_i16.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        ),
      ) as _i4.Single<_i16.Mascot>);
}

/// A class which mocks [SettingsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRepository extends _i1.Mock
    implements _i7.SettingsRepository {
  MockSettingsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<_i22.Settings> loadSettings() => (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _FakeSingle_2<_i22.Settings>(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        ),
      ) as _i4.Single<_i22.Settings>);
  @override
  _i9.Stream<_i22.Settings> streamSettings() => (super.noSuchMethod(
        Invocation.method(
          #streamSettings,
          [],
        ),
        returnValue: _i9.Stream<_i22.Settings>.empty(),
      ) as _i9.Stream<_i22.Settings>);
  @override
  _i4.Single<_i11.Unit> setFavoriteMascotId(int? id) => (super.noSuchMethod(
        Invocation.method(
          #setFavoriteMascotId,
          [id],
        ),
        returnValue: _FakeSingle_2<_i11.Unit>(
          this,
          Invocation.method(
            #setFavoriteMascotId,
            [id],
          ),
        ),
      ) as _i4.Single<_i11.Unit>);
  @override
  _i4.Single<_i11.Unit> setTalkingThreshold(_i23.DecibelLufs? threshold) =>
      (super.noSuchMethod(
        Invocation.method(
          #setTalkingThreshold,
          [threshold],
        ),
        returnValue: _FakeSingle_2<_i11.Unit>(
          this,
          Invocation.method(
            #setTalkingThreshold,
            [threshold],
          ),
        ),
      ) as _i4.Single<_i11.Unit>);
}

/// A class which mocks [StreamSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSettings extends _i1.Mock implements _i24.StreamSettings {
  MockStreamSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.SettingsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSettingsRepository_5(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i7.SettingsRepository);
  @override
  _i9.Stream<_i22.Settings> call(_i25.NoParams? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Stream<_i22.Settings>.empty(),
      ) as _i9.Stream<_i22.Settings>);
}

/// A class which mocks [SaveTalkingThreshold].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTalkingThreshold extends _i1.Mock
    implements _i26.SaveTalkingThreshold {
  MockSaveTalkingThreshold() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<_i11.Unit> call(_i23.DecibelLufs? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _FakeSingle_2<_i11.Unit>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        ),
      ) as _i4.Single<_i11.Unit>);
}

/// A class which mocks [StreamMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMascot extends _i1.Mock implements _i27.StreamMascot {
  MockStreamMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.MascotsRepository get mascotsRepository => (super.noSuchMethod(
        Invocation.getter(#mascotsRepository),
        returnValue: _FakeMascotsRepository_6(
          this,
          Invocation.getter(#mascotsRepository),
        ),
      ) as _i8.MascotsRepository);
  @override
  _i9.Stream<_i16.Mascot> call(int? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Stream<_i16.Mascot>.empty(),
      ) as _i9.Stream<_i16.Mascot>);
}

/// A class which mocks [Logger].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogger<T> extends _i1.Mock implements _i28.Logger<T> {
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

/// A class which mocks [MicrophoneContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockMicrophoneContext extends _i1.Mock implements _i29.MicrophoneContext {
  MockMicrophoneContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Single<bool> hasPermission() => (super.noSuchMethod(
        Invocation.method(
          #hasPermission,
          [],
        ),
        returnValue: _FakeSingle_2<bool>(
          this,
          Invocation.method(
            #hasPermission,
            [],
          ),
        ),
      ) as _i4.Single<bool>);
  @override
  _i9.Stream<_i23.DecibelLufs> getVolumeStream() => (super.noSuchMethod(
        Invocation.method(
          #getVolumeStream,
          [],
        ),
        returnValue: _i9.Stream<_i23.DecibelLufs>.empty(),
      ) as _i9.Stream<_i23.DecibelLufs>);
}

/// A class which mocks [Microphone].
///
/// See the documentation for Mockito's code generation for more information.
class MockMicrophone extends _i1.Mock implements _i30.Microphone {
  MockMicrophone() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Stream<_i23.DecibelLufs> get volumeStream => (super.noSuchMethod(
        Invocation.getter(#volumeStream),
        returnValue: _i9.Stream<_i23.DecibelLufs>.empty(),
      ) as _i9.Stream<_i23.DecibelLufs>);
  @override
  _i4.Single<bool> hasPermission() => (super.noSuchMethod(
        Invocation.method(
          #hasPermission,
          [],
        ),
        returnValue: _FakeSingle_2<bool>(
          this,
          Invocation.method(
            #hasPermission,
            [],
          ),
        ),
      ) as _i4.Single<bool>);
}

/// A class which mocks [StreamMicrophoneVolume].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMicrophoneVolume extends _i1.Mock
    implements _i31.StreamMicrophoneVolume {
  MockStreamMicrophoneVolume() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Stream<_i23.DecibelLufs> call(_i25.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Stream<_i23.DecibelLufs>.empty(),
      ) as _i9.Stream<_i23.DecibelLufs>);
}

/// A class which mocks [ExpressionAnimationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpressionAnimationService extends _i1.Mock
    implements _i32.ExpressionAnimationService {
  MockExpressionAnimationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Stream<_i13.Expression> animateExpressions(
          Set<_i13.Expression>? expressions) =>
      (super.noSuchMethod(
        Invocation.method(
          #animateExpressions,
          [expressions],
        ),
        returnValue: _i9.Stream<_i13.Expression>.empty(),
      ) as _i9.Stream<_i13.Expression>);
}

/// A class which mocks [StreamSubscription].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSubscription<T> extends _i1.Mock
    implements _i9.StreamSubscription<T> {
  MockStreamSubscription() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isPaused => (super.noSuchMethod(
        Invocation.getter(#isPaused),
        returnValue: false,
      ) as bool);
  @override
  _i9.Future<void> cancel() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  void onData(void Function(T)? handleData) => super.noSuchMethod(
        Invocation.method(
          #onData,
          [handleData],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(Function? handleError) => super.noSuchMethod(
        Invocation.method(
          #onError,
          [handleError],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onDone(void Function()? handleDone) => super.noSuchMethod(
        Invocation.method(
          #onDone,
          [handleDone],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void pause([_i9.Future<void>? resumeSignal]) => super.noSuchMethod(
        Invocation.method(
          #pause,
          [resumeSignal],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resume() => super.noSuchMethod(
        Invocation.method(
          #resume,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<E> asFuture<E>([E? futureValue]) => (super.noSuchMethod(
        Invocation.method(
          #asFuture,
          [futureValue],
        ),
        returnValue: _FakeFuture_7<E>(
          this,
          Invocation.method(
            #asFuture,
            [futureValue],
          ),
        ),
      ) as _i9.Future<E>);
}

/// A class which mocks [Emitter].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmitter<State> extends _i1.Mock implements _i33.Emitter<State> {
  MockEmitter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isDone => (super.noSuchMethod(
        Invocation.getter(#isDone),
        returnValue: false,
      ) as bool);
  @override
  _i9.Future<void> onEach<T>(
    _i9.Stream<T>? stream, {
    required void Function(T)? onData,
    void Function(
      Object,
      StackTrace,
    )? onError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #onEach,
          [stream],
          {
            #onData: onData,
            #onError: onError,
          },
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  _i9.Future<void> forEach<T>(
    _i9.Stream<T>? stream, {
    required State Function(T)? onData,
    State Function(
      Object,
      StackTrace,
    )? onError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #forEach,
          [stream],
          {
            #onData: onData,
            #onError: onError,
          },
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  void call(State? state) => super.noSuchMethod(
        Invocation.method(
          #call,
          [state],
        ),
        returnValueForMissingStub: null,
      );
}
