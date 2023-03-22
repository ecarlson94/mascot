// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i7;
import 'package:mascot/core/device/web/js_interop/web_audio_js.dart' as _i3;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i13;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart'
    as _i4;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i14;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart'
    as _i5;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i16;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i15;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i21;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i17;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i19;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i20;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i22;
import 'package:mascot/features/microphone/device/web/mascot_microphone.dart'
    as _i8;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart'
    as _i6;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i9;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i11;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i10;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i12;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i18;

import '../device/web/audio_context.dart' as _i23;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final audioContextModule = _$AudioContextModule();
  gh.lazySingleton<_i3.AudioContext>(() => audioContextModule.audioContext);
  gh.lazySingleton<_i4.DriftExpressionMapper>(
      () => _i4.DriftExpressionMapperImpl());
  gh.lazySingleton<_i5.DriftMascotMapper>(() => _i5.DriftMascotMapperImpl());
  gh.lazySingleton<_i6.DriftSettingsMapper>(
      () => _i6.DriftSettingsMapperImpl());
  gh.singleton<_i7.MascotDatabase>(_i7.MascotDatabase());
  gh.lazySingleton<_i8.MascotMicrophone>(
      () => _i8.MascotMicrophone(gh<_i3.AudioContext>()));
  gh.lazySingleton<_i9.SettingsDriftDataSource>(
      () => _i9.SettingsDriftDataSourceImpl(gh<_i7.MascotDatabase>()));
  gh.factory<_i10.SettingsRepository>(() => _i11.SettingsRepositoryImpl(
        gh<_i9.SettingsDriftDataSource>(),
        gh<_i6.DriftSettingsMapper>(),
      ));
  gh.factory<_i12.StreamSettings>(
      () => _i12.StreamSettings(gh<_i10.SettingsRepository>()));
  gh.lazySingleton<_i13.ExpressionsDriftDataSource>(
      () => _i13.ExpressionsDriftDataSourceImpl(gh<_i7.MascotDatabase>()));
  gh.lazySingleton<_i14.MascotsDriftDataSource>(
      () => _i14.MascotsDriftDataSourceImpl(
            gh<_i7.MascotDatabase>(),
            gh<_i13.ExpressionsDriftDataSource>(),
          ));
  gh.factory<_i15.MascotsRepository>(() => _i16.MascotsRepositoryImpl(
        gh<_i14.MascotsDriftDataSource>(),
        gh<_i5.DriftMascotMapper>(),
      ));
  gh.factory<_i17.SaveMascot>(() => _i17.SaveMascot(
        gh<_i15.MascotsRepository>(),
        gh<_i10.SettingsRepository>(),
      ));
  gh.factory<_i18.SettingsBloc>(
      () => _i18.SettingsBloc(gh<_i12.StreamSettings>()));
  gh.factory<_i19.StreamMascot>(
      () => _i19.StreamMascot(gh<_i15.MascotsRepository>()));
  gh.factory<_i20.CreateMascotBloc>(
      () => _i20.CreateMascotBloc(gh<_i17.SaveMascot>()));
  gh.factory<_i21.GetMascot>(
      () => _i21.GetMascot(gh<_i15.MascotsRepository>()));
  gh.factory<_i22.MascotAnimatorBloc>(
      () => _i22.MascotAnimatorBloc(gh<_i19.StreamMascot>()));
  return getIt;
}

class _$AudioContextModule extends _i23.AudioContextModule {}
