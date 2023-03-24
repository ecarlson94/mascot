// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i14;
import 'package:mascot/core/device/web/js_interop/web_audio/audio_context.dart'
    as _i3;
import 'package:mascot/core/device/web/js_interop/web_audio/web_audio.dart'
    as _i18;
import 'package:mascot/core/utils/logger.dart' as _i7;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i25;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart'
    as _i4;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i8;
import 'package:mascot/features/expressions/domain/entities/repositories/expressions_repository.dart'
    as _i26;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i15;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart'
    as _i5;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i13;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i16;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i9;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i27;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i22;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i31;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i28;
import 'package:mascot/features/microphone/device/microphone.dart' as _i17;
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart'
    as _i11;
import 'package:mascot/features/microphone/device/web/web_microphone.dart'
    as _i12;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i19;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i23;
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume_bloc.dart'
    as _i29;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart'
    as _i6;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i20;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i10;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i21;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i24;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i30;

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
  gh.lazySingleton<_i3.AudioContext>(
    () => _i3.AudioContext(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i4.DriftExpressionMapper>(
      () => _i4.DriftExpressionMapperImpl());
  gh.lazySingleton<_i5.DriftMascotMapper>(() => _i5.DriftMascotMapperImpl());
  gh.lazySingleton<_i6.DriftSettingsMapper>(
      () => _i6.DriftSettingsMapperImpl());
  gh.factory<_i7.Logger<_i8.ExpressionsRepositoryImpl>>(
      () => _i8.ExpressionsRepositoryLogger());
  gh.factory<_i7.Logger<_i9.AddMascot>>(() => _i9.AddMascotLogger());
  gh.factory<_i7.Logger<_i10.SettingsRepositoryImpl>>(
      () => _i10.SettingsRepositoryLogger());
  gh.factory<_i7.Logger<_i11.MicrophoneServiceImpl>>(
      () => _i11.MicrophoneServiceImplLogger());
  gh.factory<_i7.Logger<_i12.WebMicrophone>>(
      () => _i12.MascotMicrophoneLogger());
  gh.factory<_i7.Logger<_i13.MascotsRepositoryImpl>>(
      () => _i13.MascotRepositoryLogger());
  gh.singleton<_i14.MascotDatabase>(_i14.MascotDatabase());
  gh.lazySingleton<_i15.MascotsDriftDataSource>(
      () => _i15.MascotsDriftDataSourceImpl(gh<_i14.MascotDatabase>()));
  gh.factory<_i16.MascotsRepository>(() => _i13.MascotsRepositoryImpl(
        gh<_i15.MascotsDriftDataSource>(),
        gh<_i5.DriftMascotMapper>(),
        gh<_i7.Logger<_i13.MascotsRepositoryImpl>>(),
      ));
  gh.lazySingleton<_i17.Microphone>(() => _i12.WebMicrophone(
        gh<_i18.AudioContext>(),
        gh<_i7.Logger<_i12.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i19.MicrophoneService>(() => _i11.MicrophoneServiceImpl(
        gh<_i17.Microphone>(),
        gh<_i7.Logger<_i11.MicrophoneServiceImpl>>(),
      ));
  gh.lazySingleton<_i20.SettingsDriftDataSource>(
      () => _i20.SettingsDriftDataSourceImpl(gh<_i14.MascotDatabase>()));
  gh.factory<_i21.SettingsRepository>(() => _i10.SettingsRepositoryImpl(
        gh<_i20.SettingsDriftDataSource>(),
        gh<_i6.DriftSettingsMapper>(),
        gh<_i7.Logger<_i10.SettingsRepositoryImpl>>(),
      ));
  gh.factory<_i22.StreamMascot>(
      () => _i22.StreamMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i23.StreamMicrophoneVolume>(
      () => _i23.StreamMicrophoneVolume(gh<_i19.MicrophoneService>()));
  gh.factory<_i24.StreamSettings>(
      () => _i24.StreamSettings(gh<_i21.SettingsRepository>()));
  gh.lazySingleton<_i25.ExpressionsDriftDataSource>(
      () => _i25.ExpressionsDriftDataSourceImpl(gh<_i14.MascotDatabase>()));
  gh.factory<_i26.ExpressionsRepository>(() => _i8.ExpressionsRepositoryImpl(
        gh<_i25.ExpressionsDriftDataSource>(),
        gh<_i4.DriftExpressionMapper>(),
        gh<_i7.Logger<_i8.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i27.GetMascot>(
      () => _i27.GetMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i28.MascotAnimatorBloc>(
      () => _i28.MascotAnimatorBloc(gh<_i22.StreamMascot>()));
  gh.factory<_i29.MicrophoneVolumeBloc>(
      () => _i29.MicrophoneVolumeBloc(gh<_i23.StreamMicrophoneVolume>()));
  gh.factory<_i30.SettingsBloc>(
      () => _i30.SettingsBloc(gh<_i24.StreamSettings>()));
  gh.factory<_i9.AddMascot>(() => _i9.AddMascot(
        gh<_i16.MascotsRepository>(),
        gh<_i26.ExpressionsRepository>(),
        gh<_i21.SettingsRepository>(),
        gh<_i7.Logger<_i9.AddMascot>>(),
      ));
  gh.factory<_i31.CreateMascotBloc>(
      () => _i31.CreateMascotBloc(gh<_i9.AddMascot>()));
  return getIt;
}
