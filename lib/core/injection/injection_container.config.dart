// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:html' as _i16;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i12;
import 'package:mascot/core/device/web/js_interop/web_audio/audio_context.dart'
    as _i3;
import 'package:mascot/core/device/web/js_interop/web_audio/web_audio.dart'
    as _i21;
import 'package:mascot/core/utils/logger.dart' as _i7;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i17;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart'
    as _i4;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i18;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart'
    as _i5;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i11;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i19;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i28;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i23;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i25;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i27;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i29;
import 'package:mascot/features/microphone/device/microphone.dart' as _i20;
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart'
    as _i8;
import 'package:mascot/features/microphone/device/web/web_microphone.dart'
    as _i9;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i22;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i26;
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume_bloc.dart'
    as _i30;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart'
    as _i6;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i13;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i10;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i14;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i15;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i24;

import '../device/web/window/window.dart' as _i31;

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
  final windowModule = _$WindowModule();
  gh.lazySingleton<_i3.AudioContext>(() => _i3.AudioContext());
  gh.lazySingleton<_i4.DriftExpressionMapper>(
      () => _i4.DriftExpressionMapperImpl());
  gh.lazySingleton<_i5.DriftMascotMapper>(() => _i5.DriftMascotMapperImpl());
  gh.lazySingleton<_i6.DriftSettingsMapper>(
      () => _i6.DriftSettingsMapperImpl());
  gh.factory<_i7.Logger<_i8.MicrophoneServiceImpl>>(
      () => _i8.MicrophoneServiceImplLogger());
  gh.factory<_i7.Logger<_i9.WebMicrophone>>(() => _i9.MascotMicrophoneLogger());
  gh.factory<_i7.Logger<_i10.SettingsRepositoryImpl>>(
      () => _i10.SettingsRepositoryLogger());
  gh.factory<_i7.Logger<_i11.MascotsRepositoryImpl>>(
      () => _i11.MascotRepositoryLogger());
  gh.singleton<_i12.MascotDatabase>(_i12.MascotDatabase());
  gh.lazySingleton<_i13.SettingsDriftDataSource>(
      () => _i13.SettingsDriftDataSourceImpl(gh<_i12.MascotDatabase>()));
  gh.factory<_i14.SettingsRepository>(() => _i10.SettingsRepositoryImpl(
        gh<_i13.SettingsDriftDataSource>(),
        gh<_i6.DriftSettingsMapper>(),
        gh<_i7.Logger<_i10.SettingsRepositoryImpl>>(),
      ));
  gh.factory<_i15.StreamSettings>(
      () => _i15.StreamSettings(gh<_i14.SettingsRepository>()));
  gh.lazySingleton<_i16.Window>(() => windowModule.getWindow());
  gh.lazySingleton<_i17.ExpressionsDriftDataSource>(
      () => _i17.ExpressionsDriftDataSourceImpl(gh<_i12.MascotDatabase>()));
  gh.lazySingleton<_i18.MascotsDriftDataSource>(
      () => _i18.MascotsDriftDataSourceImpl(
            gh<_i12.MascotDatabase>(),
            gh<_i17.ExpressionsDriftDataSource>(),
          ));
  gh.factory<_i19.MascotsRepository>(() => _i11.MascotsRepositoryImpl(
        gh<_i18.MascotsDriftDataSource>(),
        gh<_i5.DriftMascotMapper>(),
        gh<_i7.Logger<_i11.MascotsRepositoryImpl>>(),
      ));
  gh.lazySingleton<_i20.Microphone>(() => _i9.WebMicrophone(
        gh<_i16.Window>(),
        gh<_i21.AudioContext>(),
        gh<_i7.Logger<_i9.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i22.MicrophoneService>(() => _i8.MicrophoneServiceImpl(
        gh<_i20.Microphone>(),
        gh<_i7.Logger<_i8.MicrophoneServiceImpl>>(),
      ));
  gh.factory<_i23.SaveMascot>(() => _i23.SaveMascot(
        gh<_i19.MascotsRepository>(),
        gh<_i14.SettingsRepository>(),
      ));
  gh.factory<_i24.SettingsBloc>(
      () => _i24.SettingsBloc(gh<_i15.StreamSettings>()));
  gh.factory<_i25.StreamMascot>(
      () => _i25.StreamMascot(gh<_i19.MascotsRepository>()));
  gh.factory<_i26.StreamMicrophoneVolume>(
      () => _i26.StreamMicrophoneVolume(gh<_i22.MicrophoneService>()));
  gh.factory<_i27.CreateMascotBloc>(
      () => _i27.CreateMascotBloc(gh<_i23.SaveMascot>()));
  gh.factory<_i28.GetMascot>(
      () => _i28.GetMascot(gh<_i19.MascotsRepository>()));
  gh.factory<_i29.MascotAnimatorBloc>(
      () => _i29.MascotAnimatorBloc(gh<_i25.StreamMascot>()));
  gh.factory<_i30.MicrophoneVolumeBloc>(
      () => _i30.MicrophoneVolumeBloc(gh<_i26.StreamMicrophoneVolume>()));
  return getIt;
}

class _$WindowModule extends _i31.WindowModule {}
