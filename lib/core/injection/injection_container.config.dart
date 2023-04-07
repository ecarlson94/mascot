// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i13;
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart' as _i5;
import 'package:mascot/core/device/web/js_interop/web_audio/audio_context.dart'
    as _i3;
import 'package:mascot/core/device/web/js_interop/web_audio/web_audio.dart'
    as _i18;
import 'package:mascot/core/utils/logger.dart' as _i6;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i26;
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i27;
import 'package:mascot/features/expressions/data/models/expression_mapper.dart'
    as _i4;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i9;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i28;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i15;
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i16;
import 'package:mascot/features/mascot/data/models/mascot_mapper.dart' as _i14;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i10;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i29;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i7;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i34;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i32;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i33;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i35;
import 'package:mascot/features/microphone/device/microphone.dart' as _i17;
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart'
    as _i12;
import 'package:mascot/features/microphone/device/web/web_microphone.dart'
    as _i11;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i19;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i24;
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume_bloc.dart'
    as _i30;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i20;
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i21;
import 'package:mascot/features/settings/data/models/settings_mapper.dart'
    as _i22;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i8;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i23;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i25;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i31;

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
  gh.lazySingleton<_i4.ExpressionMapper>(() => _i4.ExpressionMapperImpl());
  gh.lazySingleton<_i5.IndexDbSettings>(() => _i5.IndexDbSettings());
  gh.lazySingleton<_i5.IndexedDbFactory>(() => _i5.IndexedDbFactory());
  gh.factory<_i6.Logger<_i7.AddMascot>>(() => _i7.AddMascotLogger());
  gh.factory<_i6.Logger<_i8.SettingsRepositoryImpl>>(
      () => _i8.SettingsRepositoryLogger());
  gh.factory<_i6.Logger<_i9.ExpressionsRepositoryImpl>>(
      () => _i9.ExpressionsRepositoryLogger());
  gh.factory<_i6.Logger<_i10.MascotsRepositoryImpl>>(
      () => _i10.MascotRepositoryLogger());
  gh.factory<_i6.Logger<_i11.WebMicrophone>>(
      () => _i11.MascotMicrophoneLogger());
  gh.factory<_i6.Logger<_i12.MicrophoneServiceImpl>>(
      () => _i12.MicrophoneServiceImplLogger());
  gh.singleton<_i13.MascotDatabase>(_i13.MascotDatabase());
  gh.lazySingleton<_i14.MascotMapper>(
      () => _i14.MascotMapperImpl(gh<_i4.ExpressionMapper>()));
  gh.lazySingleton<_i15.MascotsDriftDataSource>(
      () => _i15.MascotsDriftDataSourceImpl(gh<_i13.MascotDatabase>()));
  gh.lazySingleton<_i16.MascotsIndexedDbDataSource>(
      () => _i16.MascotsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i17.Microphone>(() => _i11.WebMicrophone(
        gh<_i18.AudioContext>(),
        gh<_i6.Logger<_i11.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i19.MicrophoneService>(() => _i12.MicrophoneServiceImpl(
        gh<_i17.Microphone>(),
        gh<_i6.Logger<_i12.MicrophoneServiceImpl>>(),
      ));
  gh.lazySingleton<_i20.SettingsDriftDataSource>(
      () => _i20.SettingsDriftDataSourceImpl(gh<_i13.MascotDatabase>()));
  gh.lazySingleton<_i21.SettingsIndexedDbDataSource>(
      () => _i21.SettingsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i22.SettingsMapper>(() => _i22.SettingsMapperImpl());
  gh.factory<_i23.SettingsRepository>(() => _i8.SettingsRepositoryImpl(
        gh<_i21.SettingsIndexedDbDataSource>(),
        gh<_i22.SettingsMapper>(),
        gh<_i6.Logger<_i8.SettingsRepositoryImpl>>(),
      ));
  gh.factory<_i24.StreamMicrophoneVolume>(
      () => _i24.StreamMicrophoneVolume(gh<_i19.MicrophoneService>()));
  gh.factory<_i25.StreamSettings>(
      () => _i25.StreamSettings(gh<_i23.SettingsRepository>()));
  gh.lazySingleton<_i26.ExpressionsDriftDataSource>(
      () => _i26.ExpressionsDriftDataSourceImpl(gh<_i13.MascotDatabase>()));
  gh.lazySingleton<_i27.ExpressionsIndexedDbDataSource>(
      () => _i27.ExpressionsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.factory<_i28.ExpressionsRepository>(() => _i9.ExpressionsRepositoryImpl(
        gh<_i27.ExpressionsIndexedDbDataSource>(),
        gh<_i4.ExpressionMapper>(),
        gh<_i6.Logger<_i9.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i29.MascotsRepository>(() => _i10.MascotsRepositoryImpl(
        gh<_i16.MascotsIndexedDbDataSource>(),
        gh<_i27.ExpressionsIndexedDbDataSource>(),
        gh<_i14.MascotMapper>(),
        gh<_i6.Logger<_i10.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i30.MicrophoneVolumeBloc>(
      () => _i30.MicrophoneVolumeBloc(gh<_i24.StreamMicrophoneVolume>()));
  gh.factory<_i31.SettingsBloc>(
      () => _i31.SettingsBloc(gh<_i25.StreamSettings>()));
  gh.factory<_i32.StreamMascot>(
      () => _i32.StreamMascot(gh<_i29.MascotsRepository>()));
  gh.factory<_i7.AddMascot>(() => _i7.AddMascot(
        gh<_i29.MascotsRepository>(),
        gh<_i28.ExpressionsRepository>(),
        gh<_i23.SettingsRepository>(),
        gh<_i6.Logger<_i7.AddMascot>>(),
      ));
  gh.factory<_i33.CreateMascotBloc>(
      () => _i33.CreateMascotBloc(gh<_i7.AddMascot>()));
  gh.factory<_i34.GetMascot>(
      () => _i34.GetMascot(gh<_i29.MascotsRepository>()));
  gh.factory<_i35.MascotAnimatorBloc>(
      () => _i35.MascotAnimatorBloc(gh<_i32.StreamMascot>()));
  return getIt;
}
