// Mocks generated by Mockito 5.3.2 from annotations
// in mascot/test/fixtures/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mascot/core/clean_architecture/usecase.dart' as _i21;
import 'package:mascot/core/error/failure.dart' as _i11;
import 'package:mascot/core/utils/logger.dart' as _i23;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i8;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i2;
import 'package:mascot/features/expressions/domain/entities/expression.dart'
    as _i12;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i10;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i14;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i5;
import 'package:mascot/features/mascot/domain/entities/mascot.dart' as _i15;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i7;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i17;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i18;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i22;
import 'package:mascot/features/microphone/device/microphone.dart' as _i26;
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart'
    as _i25;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i24;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i27;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i13;
import 'package:mascot/features/settings/data/models/settings_model.dart'
    as _i4;
import 'package:mascot/features/settings/domain/entities/settings.dart' as _i19;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i6;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i20;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i16;

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

class _FakeExpressionModel_0 extends _i1.SmartFake
    implements _i2.ExpressionModel {
  _FakeExpressionModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettingsModel_2 extends _i1.SmartFake implements _i4.SettingsModel {
  _FakeSettingsModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnit_3 extends _i1.SmartFake implements _i3.Unit {
  _FakeUnit_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMascotModel_4 extends _i1.SmartFake implements _i5.MascotModel {
  _FakeMascotModel_4(
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
  _i9.Future<int> upsertExpression(_i2.ExpressionModel? expression) =>
      (super.noSuchMethod(
        Invocation.method(
          #upsertExpression,
          [expression],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<List<int>> upsertExpressions(
          Iterable<_i2.ExpressionModel>? expressions) =>
      (super.noSuchMethod(
        Invocation.method(
          #upsertExpressions,
          [expressions],
        ),
        returnValue: _i9.Future<List<int>>.value(<int>[]),
      ) as _i9.Future<List<int>>);
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
  _i9.Future<_i2.ExpressionModel> getExpression(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getExpression,
          [id],
        ),
        returnValue:
            _i9.Future<_i2.ExpressionModel>.value(_FakeExpressionModel_0(
          this,
          Invocation.method(
            #getExpression,
            [id],
          ),
        )),
      ) as _i9.Future<_i2.ExpressionModel>);
  @override
  _i9.Future<List<_i2.ExpressionModel>> getExpressions(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpressions,
          [ids],
        ),
        returnValue: _i9.Future<List<_i2.ExpressionModel>>.value(
            <_i2.ExpressionModel>[]),
      ) as _i9.Future<List<_i2.ExpressionModel>>);
  @override
  _i9.Stream<List<_i2.ExpressionModel>> streamExpressions(Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamExpressions,
          [ids],
        ),
        returnValue: _i9.Stream<List<_i2.ExpressionModel>>.empty(),
      ) as _i9.Stream<List<_i2.ExpressionModel>>);
}

/// A class which mocks [ExpressionsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpressionsRepository extends _i1.Mock
    implements _i10.ExpressionsRepository {
  MockExpressionsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, List<int>>> saveExpressions(
          Iterable<_i12.Expression>? expressions) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveExpressions,
          [expressions],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, List<int>>>.value(
            _FakeEither_1<_i11.Failure, List<int>>(
          this,
          Invocation.method(
            #saveExpressions,
            [expressions],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, List<int>>>);
  @override
  _i9.Future<_i3.Either<_i11.Failure, List<_i12.Expression>>> getExpressions(
          Iterable<int>? ids) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpressions,
          [ids],
        ),
        returnValue:
            _i9.Future<_i3.Either<_i11.Failure, List<_i12.Expression>>>.value(
                _FakeEither_1<_i11.Failure, List<_i12.Expression>>(
          this,
          Invocation.method(
            #getExpressions,
            [ids],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, List<_i12.Expression>>>);
}

/// A class which mocks [SettingsDriftDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsDriftDataSource extends _i1.Mock
    implements _i13.SettingsDriftDataSource {
  MockSettingsDriftDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i4.SettingsModel> loadSettings() => (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _i9.Future<_i4.SettingsModel>.value(_FakeSettingsModel_2(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        )),
      ) as _i9.Future<_i4.SettingsModel>);
  @override
  _i9.Stream<_i4.SettingsModel?> streamSettings() => (super.noSuchMethod(
        Invocation.method(
          #streamSettings,
          [],
        ),
        returnValue: _i9.Stream<_i4.SettingsModel?>.empty(),
      ) as _i9.Stream<_i4.SettingsModel?>);
  @override
  _i9.Future<_i3.Unit> saveSettings(_i4.SettingsModel? settings) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSettings,
          [settings],
        ),
        returnValue: _i9.Future<_i3.Unit>.value(_FakeUnit_3(
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
    implements _i14.MascotsDriftDataSource {
  MockMascotsDriftDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<int> upsertMascot(_i5.MascotModel? mascot) => (super.noSuchMethod(
        Invocation.method(
          #upsertMascot,
          [mascot],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<_i5.MascotModel> getMascot(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _i9.Future<_i5.MascotModel>.value(_FakeMascotModel_4(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        )),
      ) as _i9.Future<_i5.MascotModel>);
  @override
  _i9.Stream<_i5.MascotModel?> streamMascot(int? id) => (super.noSuchMethod(
        Invocation.method(
          #streamMascot,
          [id],
        ),
        returnValue: _i9.Stream<_i5.MascotModel?>.empty(),
      ) as _i9.Stream<_i5.MascotModel?>);
  @override
  _i9.Stream<List<_i2.ExpressionModel>?> streamExpressionsForMascot(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #streamExpressionsForMascot,
          [id],
        ),
        returnValue: _i9.Stream<List<_i2.ExpressionModel>?>.empty(),
      ) as _i9.Stream<List<_i2.ExpressionModel>?>);
}

/// A class which mocks [MascotsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMascotsRepository extends _i1.Mock implements _i7.MascotsRepository {
  MockMascotsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, int>> saveMascot(_i15.Mascot? mascot) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveMascot,
          [mascot],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, int>>.value(
            _FakeEither_1<_i11.Failure, int>(
          this,
          Invocation.method(
            #saveMascot,
            [mascot],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, int>>);
  @override
  _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>> getMascot(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMascot,
          [id],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>.value(
            _FakeEither_1<_i11.Failure, _i15.Mascot>(
          this,
          Invocation.method(
            #getMascot,
            [id],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>);
  @override
  _i9.Future<_i3.Either<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>>
      streamMascot(int? id) => (super.noSuchMethod(
            Invocation.method(
              #streamMascot,
              [id],
            ),
            returnValue: _i9.Future<
                    _i3.Either<_i11.Failure,
                        _i16.BehaviorSubject<_i15.Mascot>>>.value(
                _FakeEither_1<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>(
              this,
              Invocation.method(
                #streamMascot,
                [id],
              ),
            )),
          ) as _i9.Future<
              _i3.Either<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>>);
}

/// A class which mocks [AddMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddMascot extends _i1.Mock implements _i17.AddMascot {
  MockAddMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>> call(_i15.Mascot? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>.value(
            _FakeEither_1<_i11.Failure, _i15.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>);
}

/// A class which mocks [GetMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMascot extends _i1.Mock implements _i18.GetMascot {
  MockGetMascot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>> call(int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>.value(
            _FakeEither_1<_i11.Failure, _i15.Mascot>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i15.Mascot>>);
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
  _i9.Future<_i3.Either<_i11.Failure, _i19.Settings>> loadSettings() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSettings,
          [],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, _i19.Settings>>.value(
            _FakeEither_1<_i11.Failure, _i19.Settings>(
          this,
          Invocation.method(
            #loadSettings,
            [],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i19.Settings>>);
  @override
  _i9.Future<_i3.Either<_i11.Failure, _i16.BehaviorSubject<_i19.Settings>>>
      streamSettings() => (super.noSuchMethod(
            Invocation.method(
              #streamSettings,
              [],
            ),
            returnValue: _i9.Future<
                _i3.Either<_i11.Failure,
                    _i16.BehaviorSubject<_i19.Settings>>>.value(_FakeEither_1<
                _i11.Failure, _i16.BehaviorSubject<_i19.Settings>>(
              this,
              Invocation.method(
                #streamSettings,
                [],
              ),
            )),
          ) as _i9.Future<
              _i3.Either<_i11.Failure, _i16.BehaviorSubject<_i19.Settings>>>);
  @override
  _i9.Future<_i3.Either<_i11.Failure, _i3.Unit>> setFavoriteMascotId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFavoriteMascotId,
          [id],
        ),
        returnValue: _i9.Future<_i3.Either<_i11.Failure, _i3.Unit>>.value(
            _FakeEither_1<_i11.Failure, _i3.Unit>(
          this,
          Invocation.method(
            #setFavoriteMascotId,
            [id],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i3.Unit>>);
}

/// A class which mocks [StreamSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSettings extends _i1.Mock implements _i20.StreamSettings {
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
  _i9.Future<
      _i3.Either<_i11.Failure, _i16.BehaviorSubject<_i19.Settings>>> call(
          _i21.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<
                _i3.Either<_i11.Failure,
                    _i16.BehaviorSubject<_i19.Settings>>>.value(
            _FakeEither_1<_i11.Failure, _i16.BehaviorSubject<_i19.Settings>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<
          _i3.Either<_i11.Failure, _i16.BehaviorSubject<_i19.Settings>>>);
}

/// A class which mocks [StreamMascot].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMascot extends _i1.Mock implements _i22.StreamMascot {
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
  _i9.Future<_i3.Either<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>> call(
          int? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<
                _i3.Either<_i11.Failure,
                    _i16.BehaviorSubject<_i15.Mascot>>>.value(
            _FakeEither_1<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9
          .Future<_i3.Either<_i11.Failure, _i16.BehaviorSubject<_i15.Mascot>>>);
}

/// A class which mocks [Logger].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogger<T> extends _i1.Mock implements _i23.Logger<T> {
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
class MockMicrophoneService extends _i1.Mock implements _i24.MicrophoneService {
  MockMicrophoneService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>>
      getVolumeStream() => (super.noSuchMethod(
            Invocation.method(
              #getVolumeStream,
              [],
            ),
            returnValue: _i9.Future<
                    _i3.Either<_i11.Failure,
                        _i9.Stream<_i25.DecibelLufs>>>.value(
                _FakeEither_1<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>(
              this,
              Invocation.method(
                #getVolumeStream,
                [],
              ),
            )),
          ) as _i9
              .Future<_i3.Either<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>>);
}

/// A class which mocks [Microphone].
///
/// See the documentation for Mockito's code generation for more information.
class MockMicrophone extends _i1.Mock implements _i26.Microphone {
  MockMicrophone() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Stream<_i25.DecibelLufs> get volumeStream => (super.noSuchMethod(
        Invocation.getter(#volumeStream),
        returnValue: _i9.Stream<_i25.DecibelLufs>.empty(),
      ) as _i9.Stream<_i25.DecibelLufs>);
  @override
  _i9.Future<bool> hasPermission() => (super.noSuchMethod(
        Invocation.method(
          #hasPermission,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
}

/// A class which mocks [StreamMicrophoneVolume].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamMicrophoneVolume extends _i1.Mock
    implements _i27.StreamMicrophoneVolume {
  MockStreamMicrophoneVolume() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i3.Either<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>> call(
          _i21.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i9.Future<
                _i3.Either<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>>.value(
            _FakeEither_1<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i9.Future<_i3.Either<_i11.Failure, _i9.Stream<_i25.DecibelLufs>>>);
}
