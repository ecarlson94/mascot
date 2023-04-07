// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart' as _i5;
import 'package:mascot/core/device/web/js_interop/web_audio/audio_context.dart'
    as _i3;
import 'package:mascot/core/device/web/js_interop/web_audio/web_audio.dart'
    as _i16;
import 'package:mascot/core/utils/logger.dart' as _i6;
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i23;
import 'package:mascot/features/expressions/data/models/expression_mapper.dart'
    as _i4;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i10;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i24;
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i14;
import 'package:mascot/features/mascot/data/models/mascot_mapper.dart' as _i13;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i8;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i25;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i12;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i30;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i28;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i29;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i31;
import 'package:mascot/features/microphone/device/microphone.dart' as _i15;
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart'
    as _i11;
import 'package:mascot/features/microphone/device/web/web_microphone.dart'
    as _i7;
import 'package:mascot/features/microphone/domain/services/microphone_service.dart'
    as _i17;
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i21;
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume_bloc.dart'
    as _i26;
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i18;
import 'package:mascot/features/settings/data/models/settings_mapper.dart'
    as _i19;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i9;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i20;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i22;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i27;

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
  gh.factory<_i6.Logger<_i7.WebMicrophone>>(() => _i7.MascotMicrophoneLogger());
  gh.factory<_i6.Logger<_i8.MascotsRepositoryImpl>>(
      () => _i8.MascotRepositoryLogger());
  gh.factory<_i6.Logger<_i9.SettingsRepositoryImpl>>(
      () => _i9.SettingsRepositoryLogger());
  gh.factory<_i6.Logger<_i10.ExpressionsRepositoryImpl>>(
      () => _i10.ExpressionsRepositoryLogger());
  gh.factory<_i6.Logger<_i11.MicrophoneServiceImpl>>(
      () => _i11.MicrophoneServiceImplLogger());
  gh.factory<_i6.Logger<_i12.AddMascot>>(() => _i12.AddMascotLogger());
  gh.lazySingleton<_i13.MascotMapper>(
      () => _i13.MascotMapperImpl(gh<_i4.ExpressionMapper>()));
  gh.lazySingleton<_i14.MascotsIndexedDbDataSource>(
      () => _i14.MascotsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i15.Microphone>(() => _i7.WebMicrophone(
        gh<_i16.AudioContext>(),
        gh<_i6.Logger<_i7.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i17.MicrophoneService>(() => _i11.MicrophoneServiceImpl(
        gh<_i15.Microphone>(),
        gh<_i6.Logger<_i11.MicrophoneServiceImpl>>(),
      ));
  gh.lazySingleton<_i18.SettingsIndexedDbDataSource>(
      () => _i18.SettingsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i19.SettingsMapper>(() => _i19.SettingsMapperImpl());
  gh.factory<_i20.SettingsRepository>(() => _i9.SettingsRepositoryImpl(
        gh<_i18.SettingsIndexedDbDataSource>(),
        gh<_i19.SettingsMapper>(),
        gh<_i6.Logger<_i9.SettingsRepositoryImpl>>(),
      ));
  gh.factory<_i21.StreamMicrophoneVolume>(
      () => _i21.StreamMicrophoneVolume(gh<_i17.MicrophoneService>()));
  gh.factory<_i22.StreamSettings>(
      () => _i22.StreamSettings(gh<_i20.SettingsRepository>()));
  gh.lazySingleton<_i23.ExpressionsIndexedDbDataSource>(
      () => _i23.ExpressionsIndexedDbDataSource(
            gh<_i5.IndexedDbFactory>(),
            gh<_i5.IndexDbSettings>(),
          ));
  gh.factory<_i24.ExpressionsRepository>(() => _i10.ExpressionsRepositoryImpl(
        gh<_i23.ExpressionsIndexedDbDataSource>(),
        gh<_i4.ExpressionMapper>(),
        gh<_i6.Logger<_i10.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i25.MascotsRepository>(() => _i8.MascotsRepositoryImpl(
        gh<_i14.MascotsIndexedDbDataSource>(),
        gh<_i23.ExpressionsIndexedDbDataSource>(),
        gh<_i13.MascotMapper>(),
        gh<_i6.Logger<_i8.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i26.MicrophoneVolumeBloc>(
      () => _i26.MicrophoneVolumeBloc(gh<_i21.StreamMicrophoneVolume>()));
  gh.factory<_i27.SettingsBloc>(
      () => _i27.SettingsBloc(gh<_i22.StreamSettings>()));
  gh.factory<_i28.StreamMascot>(
      () => _i28.StreamMascot(gh<_i25.MascotsRepository>()));
  gh.factory<_i12.AddMascot>(() => _i12.AddMascot(
        gh<_i25.MascotsRepository>(),
        gh<_i24.ExpressionsRepository>(),
        gh<_i20.SettingsRepository>(),
        gh<_i6.Logger<_i12.AddMascot>>(),
      ));
  gh.factory<_i29.CreateMascotBloc>(
      () => _i29.CreateMascotBloc(gh<_i12.AddMascot>()));
  gh.factory<_i30.GetMascot>(
      () => _i30.GetMascot(gh<_i25.MascotsRepository>()));
  gh.factory<_i31.MascotAnimatorBloc>(
      () => _i31.MascotAnimatorBloc(gh<_i28.StreamMascot>()));
  return getIt;
}
