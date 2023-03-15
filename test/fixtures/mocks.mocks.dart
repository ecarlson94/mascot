// Mocks generated by Mockito 5.3.2 from annotations
// in mascot/test/fixtures/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mascot/core/clean_architecture/usecase.dart' as _i19;
import 'package:mascot/core/error/failure.dart' as _i13;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i8;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression.dart'
    as _i10;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i12;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot.dart'
    as _i4;
import 'package:mascot/features/mascot/domain/entities/mascot.dart' as _i14;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i7;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i16;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i15;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i20;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings.dart'
    as _i2;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i11;
import 'package:mascot/features/settings/domain/entities/settings.dart' as _i17;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i6;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i18;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i5;

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

class _FakeDriftSettings_0 extends _i1.SmartFake implements _i2.DriftSettings {
  _FakeDriftSettings_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnit_1 extends _i1.SmartFake implements _i3.Unit {
  _FakeUnit_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDriftMascot_2 extends _i1.SmartFake implements _i4.DriftMascot {
  _FakeDriftMascot_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBehaviorSubject_3<T> extends _i1.SmartFake
    implements _i5.BehaviorSubject<T> {
  _FakeBehaviorSubject_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_4<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsRepository_5 extends _i1.SmartFake
    implements _i6.SettingsRepository {
  _FakeSettingsRepository_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotsRepository_6 extends _i1.SmartFake
    implements _i7.MascotsRepository {
  _FakeMascotsRepository_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ExpressionsDriftDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpressionsDriftDataSource extends _i1.Mock
    implements _i8.ExpressionsDriftDataSource {
  MockExpressionsDriftDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<int> upsertExpression(_i10.DriftExpression? expression) =>
      (super.noSuchMethod(
        Invocation.method(
          #upsertExpression,
          [expression],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<void> removeExpression(int? id) => (super.noSuchMethod(
        Invocation.method(
          #removeExpression,
          [id],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  _i9.Future<List<_i10.DriftExpression>> getExpressions(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpressions,
          [ids],
        ),
        returnValue: _i9.Future<List<_i10.DriftExpression>>.value(
            <_i10.DriftExpression>[]),
      ) as _i9.Future<List<_i10.DriftExpression>>);
  @override
  _i9.Stream<List<_i10.DriftExpression>> streamExpressions(List<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamExpressions,
          [ids],
        ),
        returnValue: _i9.Stream<List<_i10.DriftExpression>>.empty(),
      ) as _i9.Stream<List<_i10.DriftExpression>>);
}

/// A class which mocks [SettingsDriftDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsDriftDataSource extends _i1.Mock
    implements _i11.SettingsDriftDataSource {
  MockSettingsDriftDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.DriftSettings> loadSettings() => (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _i9.Future<_i2.DriftSettings>.value(_FakeDriftSettings_0(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        )),
      ) as _i9.Future<_i2.DriftSettings>);
  @override
  _i9.Stream<_i2.DriftSettings?> streamSettings() => (super.noSuchMethod(
        Invocation.method(
          #streamSettings,
          [],
        ),
        returnValue: _i9.Stream<_i2.DriftSettings?>.empty(),
      ) as _i9.Stream<_i2.DriftSettings?>);
  @override
  _i9.Future<_i3.Unit> saveSettings(_i2.DriftSettings? settings) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSettings,
          [settings],
        ),
        returnValue: _i9.Future<_i3.Unit>.value(_FakeUnit_1(
          this,
          Invocation.method(
            #saveSettings,
            [settings],
          ),
        )),
      ) as _i9.Future<_i3.Unit>);
}

/// A class which mocks [MascotsDriftDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsDriftDataSource extends _i1.Mock
    implements _i12.MascotsDriftDataSource {
  MockMascotsDriftDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<int> addMascot(_i4.DriftMascot? mascot) => (super.noSuchMethod(
        Invocation.method(
          #addMascot,
          [mascot],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<_i4.DriftMascot> getMascot(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _i9.Future<_i4.DriftMascot>.value(_FakeDriftMascot_2(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        )),
      ) as _i9.Future<_i4.DriftMascot>);
  @override
  _i9.Future<_i5.BehaviorSubject<_i4.DriftMascot>> streamMascot(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamMascot,
          [id],
        ),
        returnValue: _i9.Future<_i5.BehaviorSubject<_i4.DriftMascot>>.value(
            _FakeBehaviorSubject_3<_i4.DriftMascot>(
          this,
          Invocation.method(
            #streamMascot,
            [id],
          ),
        )),
      ) as _i9.Future<_i5.BehaviorSubject<_i4.DriftMascot>>);
}

/// A class which mocks [MascotsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsRepository extends _i1.Mock implements _i7.MascotsRepository {
  MockMascotsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i13.Failure, int>> addMascot(_i14.Mascot? mascot) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMascot,
          [mascot],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, int>>.value(
            _FakeEither_4<_i13.Failure, int>(
          this,
          Invocation.method(
            #addMascot,
            [mascot],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, int>>);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>> getMascot(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>>.value(
            _FakeEither_4<_i13.Failure, _i14.Mascot>(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>>);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>>
      streamMascot(int? id) => (super.noSuchMethod(
            Invocation.method(
              #streamMascot,
              [id],
            ),
            returnValue: _i9.Future<
                    _i3.Either<_i13.Failure,
                        _i5.BehaviorSubject<_i14.Mascot>>>.value(
                _FakeEither_4<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>(
              this,
              Invocation.method(
                #streamMascot,
                [id],
              ),
            )),
          ) as _i9.Future<
              _i3.Either<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>>);
}

/// A class which mocks [SaveMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveMascot extends _i1.Mock implements _i15.SaveMascot {
  MockSaveMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i13.Failure, int>> call(_i14.Mascot? mascot) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [mascot],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, int>>.value(
            _FakeEither_4<_i13.Failure, int>(
          this,
          Invocation.method(
            #call,
            [mascot],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, int>>);
}

/// A class which mocks [GetMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMascot extends _i1.Mock implements _i16.GetMascot {
  MockGetMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>> call(int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>>.value(
            _FakeEither_4<_i13.Failure, _i14.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, _i14.Mascot>>);
}

/// A class which mocks [SettingsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRepository extends _i1.Mock
    implements _i6.SettingsRepository {
  MockSettingsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i13.Failure, _i17.Settings>> loadSettings() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, _i17.Settings>>.value(
            _FakeEither_4<_i13.Failure, _i17.Settings>(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, _i17.Settings>>);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>>
      streamSettings() => (super.noSuchMethod(
            Invocation.method(
              #streamSettings,
              [],
            ),
            returnValue: _i9.Future<
                    _i3.Either<_i13.Failure,
                        _i5.BehaviorSubject<_i17.Settings>>>.value(
                _FakeEither_4<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>(
              this,
              Invocation.method(
                #streamSettings,
                [],
              ),
            )),
          ) as _i9.Future<
              _i3.Either<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>>);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i3.Unit>> setFavoriteMascotId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFavoriteMascotId,
          [id],
        ),
        returnValue: _i9.Future<_i3.Either<_i13.Failure, _i3.Unit>>.value(
            _FakeEither_4<_i13.Failure, _i3.Unit>(
          this,
          Invocation.method(
            #setFavoriteMascotId,
            [id],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i13.Failure, _i3.Unit>>);
}

/// A class which mocks [StreamSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSettings extends _i1.Mock implements _i18.StreamSettings {
  MockStreamSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.SettingsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSettingsRepository_5(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i6.SettingsRepository);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>> call(
          _i19.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<
                _i3.Either<_i13.Failure,
                    _i5.BehaviorSubject<_i17.Settings>>>.value(
            _FakeEither_4<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<
          _i3.Either<_i13.Failure, _i5.BehaviorSubject<_i17.Settings>>>);
}

/// A class which mocks [StreamMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMascot extends _i1.Mock implements _i20.StreamMascot {
  MockStreamMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.MascotsRepository get mascotsRepository => (super.noSuchMethod(
        Invocation.getter(#mascotsRepository),
        returnValue: _FakeMascotsRepository_6(
          this,
          Invocation.getter(#mascotsRepository),
        ),
      ) as _i7.MascotsRepository);
  @override
  _i9.Future<_i3.Either<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>> call(
          int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<
                _i3.Either<_i13.Failure,
                    _i5.BehaviorSubject<_i14.Mascot>>>.value(
            _FakeEither_4<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9
          .Future<_i3.Either<_i13.Failure, _i5.BehaviorSubject<_i14.Mascot>>>);
}
