// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i11;
import 'package:mascot/core/device/web/audio_context.dart' as _i15;
import 'package:mascot/core/utils/logger.dart' as _i6;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i16;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart'
    as _i3;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i17;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart'
    as _i4;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i8;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i18;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i25;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i20;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i22;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i24;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i26;
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart'
    as _i9;
import 'package:mascot/features/microphone/device/web/web_microphone_impl.dart'
    as _i10;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i19;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i23;
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume_bloc.dart'
    as _i27;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart'
    as _i5;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i12;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i7;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i13;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i14;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i21;

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
  gh.lazySingleton<_i3.DriftExpressionMapper>(
      () => _i3.DriftExpressionMapperImpl());
  gh.lazySingleton<_i4.DriftMascotMapper>(() => _i4.DriftMascotMapperImpl());
  gh.lazySingleton<_i5.DriftSettingsMapper>(
      () => _i5.DriftSettingsMapperImpl());
  gh.factory<_i6.Logger<_i7.SettingsRepositoryImpl>>(
      () => _i7.SettingsRepositoryLogger());
  gh.factory<_i6.Logger<_i8.MascotsRepositoryImpl>>(
      () => _i8.MascotRepositoryLogger());
  gh.factory<_i6.Logger<_i9.MicrophoneServiceImpl>>(
      () => _i9.MicrophoneServiceImplLogger());
  gh.factory<_i6.Logger<_i10.WebMicrophoneImpl>>(
      () => _i10.MascotMicrophoneLogger());
  gh.singleton<_i11.MascotDatabase>(_i11.MascotDatabase());
  gh.lazySingleton<_i12.SettingsDriftDataSource>(
      () => _i12.SettingsDriftDataSourceImpl(gh<_i11.MascotDatabase>()));
  gh.factory<_i13.SettingsRepository>(() => _i7.SettingsRepositoryImpl(
        gh<_i12.SettingsDriftDataSource>(),
        gh<_i5.DriftSettingsMapper>(),
        gh<_i6.Logger<_i7.SettingsRepositoryImpl>>(),
      ));
  gh.factory<_i14.StreamSettings>(
      () => _i14.StreamSettings(gh<_i13.SettingsRepository>()));
  gh.lazySingleton<_i15.WebAudio>(
    () => _i15.WebAudio(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i10.WebMicrophone>(() => _i10.WebMicrophoneImpl(
        gh<_i15.WebAudio>(),
        gh<_i6.Logger<_i10.WebMicrophoneImpl>>(),
      ));
  gh.lazySingleton<_i16.ExpressionsDriftDataSource>(
      () => _i16.ExpressionsDriftDataSourceImpl(gh<_i11.MascotDatabase>()));
  gh.lazySingleton<_i17.MascotsDriftDataSource>(
      () => _i17.MascotsDriftDataSourceImpl(
            gh<_i11.MascotDatabase>(),
            gh<_i16.ExpressionsDriftDataSource>(),
          ));
  gh.factory<_i18.MascotsRepository>(() => _i8.MascotsRepositoryImpl(
        gh<_i17.MascotsDriftDataSource>(),
        gh<_i4.DriftMascotMapper>(),
        gh<_i6.Logger<_i8.MascotsRepositoryImpl>>(),
      ));
  gh.lazySingleton<_i19.MicrophoneService>(() => _i9.MicrophoneServiceImpl(
        gh<_i10.WebMicrophone>(),
        gh<_i6.Logger<_i9.MicrophoneServiceImpl>>(),
      ));
  gh.factory<_i20.SaveMascot>(() => _i20.SaveMascot(
        gh<_i18.MascotsRepository>(),
        gh<_i13.SettingsRepository>(),
      ));
  gh.factory<_i21.SettingsBloc>(
      () => _i21.SettingsBloc(gh<_i14.StreamSettings>()));
  gh.factory<_i22.StreamMascot>(
      () => _i22.StreamMascot(gh<_i18.MascotsRepository>()));
  gh.factory<_i23.StreamMicrophoneVolume>(
      () => _i23.StreamMicrophoneVolume(gh<_i19.MicrophoneService>()));
  gh.factory<_i24.CreateMascotBloc>(
      () => _i24.CreateMascotBloc(gh<_i20.SaveMascot>()));
  gh.factory<_i25.GetMascot>(
      () => _i25.GetMascot(gh<_i18.MascotsRepository>()));
  gh.factory<_i26.MascotAnimatorBloc>(
      () => _i26.MascotAnimatorBloc(gh<_i22.StreamMascot>()));
  gh.factory<_i27.MicrophoneVolumeBloc>(
      () => _i27.MicrophoneVolumeBloc(gh<_i23.StreamMicrophoneVolume>()));
  return getIt;
}
