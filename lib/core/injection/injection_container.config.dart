// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/actions/presentation/bloc/actions_overlay_bloc.dart'
    as _i3;
import '../../features/camera/presentation/bloc/camera_controller_bloc.dart'
    as _i37;
import '../../features/camera/presentation/bloc/effects/load_camera_controller.dart'
    as _i10;
import '../../features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i28;
import '../../features/expressions/data/models/expression_mapper.dart' as _i5;
import '../../features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i12;
import '../../features/expressions/domain/repositories/expressions_repository.dart'
    as _i29;
import '../../features/expressions/domain/services/animation/expression_animation_service.dart'
    as _i38;
import '../../features/expressions/domain/services/animation/expression_trigger_factory.dart'
    as _i27;
import '../../features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i15;
import '../../features/mascot/data/models/mascot_mapper.dart' as _i14;
import '../../features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i11;
import '../../features/mascot/domain/repositories/mascots_repository.dart'
    as _i30;
import '../../features/mascot/domain/usecases/add_mascot.dart' as _i13;
import '../../features/mascot/domain/usecases/get_mascot.dart' as _i39;
import '../../features/mascot/domain/usecases/stream_mascot.dart' as _i35;
import '../../features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart'
    as _i42;
import '../../features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart'
    as _i41;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart'
    as _i40;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart'
    as _i36;
import '../../features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart'
    as _i43;
import '../../features/microphone/device/microphone.dart' as _i16;
import '../../features/microphone/device/services/microphone_service_impl.dart'
    as _i9;
import '../../features/microphone/device/web/web_microphone.dart' as _i8;
import '../../features/microphone/domain/services/microphone_service.dart'
    as _i18;
import '../../features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i23;
import '../../features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart'
    as _i26;
import '../../features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart'
    as _i31;
import '../../features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i19;
import '../../features/settings/data/models/settings_mapper.dart' as _i20;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i22;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i21;
import '../../features/settings/domain/usecases/save_talking_threshold.dart'
    as _i32;
import '../../features/settings/domain/usecases/stream_settings.dart' as _i24;
import '../../features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart'
    as _i33;
import '../../features/settings/presentation/bloc/effects/stream_settings_effect.dart'
    as _i25;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i34;
import '../data/indexed_db/indexed_db_data_source.dart' as _i6;
import '../device/web/js_interop/web_audio/audio_context.dart' as _i4;
import '../device/web/js_interop/web_audio/web_audio.dart' as _i17;
import '../utils/logger.dart' as _i7;

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
  gh.factory<_i3.ActionsOverlayBloc>(() => _i3.ActionsOverlayBloc());
  gh.lazySingleton<_i4.AudioContext>(
    () => _i4.AudioContext(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i5.ExpressionMapper>(() => _i5.ExpressionMapperImpl());
  gh.lazySingleton<_i6.IndexDbSettings>(() => _i6.IndexDbSettings());
  gh.lazySingleton<_i6.IndexedDbFactory>(() => _i6.IndexedDbFactory());
  gh.factory<_i7.Logger<_i8.WebMicrophone>>(() => _i8.MascotMicrophoneLogger());
  gh.factory<_i7.Logger<_i9.MicrophoneServiceImpl>>(
      () => _i9.MicrophoneServiceImplLogger());
  gh.factory<_i7.Logger<_i10.LoadCameraController>>(
      () => _i10.LoadCameraLogger());
  gh.factory<_i7.Logger<_i11.MascotsRepositoryImpl>>(
      () => _i11.MascotRepositoryLogger());
  gh.factory<_i7.Logger<_i12.ExpressionsRepositoryImpl>>(
      () => _i12.ExpressionsRepositoryLogger());
  gh.factory<_i7.Logger<_i13.AddMascot>>(() => _i13.AddMascotLogger());
  gh.lazySingleton<_i14.MascotMapper>(
      () => _i14.MascotMapperImpl(gh<_i5.ExpressionMapper>()));
  gh.lazySingleton<_i15.MascotsIndexedDbDataSource>(
      () => _i15.MascotsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i16.Microphone>(() => _i8.WebMicrophone(
        gh<_i17.AudioContext>(),
        gh<_i7.Logger<_i8.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i18.MicrophoneService>(() => _i9.MicrophoneServiceImpl(
        gh<_i16.Microphone>(),
        gh<_i7.Logger<_i9.MicrophoneServiceImpl>>(),
      ));
  gh.lazySingleton<_i19.SettingsIndexedDbDataSource>(
      () => _i19.SettingsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i20.SettingsMapper>(() => _i20.SettingsMapperImpl());
  gh.factory<_i21.SettingsRepository>(() => _i22.SettingsRepositoryImpl(
        gh<_i19.SettingsIndexedDbDataSource>(),
        gh<_i20.SettingsMapper>(),
      ));
  gh.factory<_i23.StreamMicrophoneVolume>(
      () => _i23.StreamMicrophoneVolume(gh<_i18.MicrophoneService>()));
  gh.factory<_i24.StreamSettings>(
      () => _i24.StreamSettings(gh<_i21.SettingsRepository>()));
  gh.factory<_i25.StreamSettingsEffect>(
      () => _i25.StreamSettingsEffect(gh<_i24.StreamSettings>()));
  gh.factory<_i26.StreamVolumeEffect>(
      () => _i26.StreamVolumeEffect(gh<_i23.StreamMicrophoneVolume>()));
  gh.factory<_i27.ExpressionTriggerFactory>(() => _i27.ExpressionTriggerFactory(
        gh<_i21.SettingsRepository>(),
        gh<_i23.StreamMicrophoneVolume>(),
      ));
  gh.lazySingleton<_i28.ExpressionsIndexedDbDataSource>(
      () => _i28.ExpressionsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.factory<_i29.ExpressionsRepository>(() => _i12.ExpressionsRepositoryImpl(
        gh<_i28.ExpressionsIndexedDbDataSource>(),
        gh<_i5.ExpressionMapper>(),
        gh<_i7.Logger<_i12.ExpressionsRepositoryImpl>>(),
      ));
  gh.lazySingleton<_i10.LoadCameraController>(() =>
      _i10.LoadCameraController(gh<_i7.Logger<_i10.LoadCameraController>>()));
  gh.factory<_i30.MascotsRepository>(() => _i11.MascotsRepositoryImpl(
        gh<_i15.MascotsIndexedDbDataSource>(),
        gh<_i28.ExpressionsIndexedDbDataSource>(),
        gh<_i14.MascotMapper>(),
        gh<_i7.Logger<_i11.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i31.MicrophoneVolumeBloc>(
      () => _i31.MicrophoneVolumeBloc(gh<_i26.StreamVolumeEffect>()));
  gh.factory<_i32.SaveTalkingThreshold>(
      () => _i32.SaveTalkingThreshold(gh<_i21.SettingsRepository>()));
  gh.factory<_i33.SetTalkingThresholdEffect>(
      () => _i33.SetTalkingThresholdEffect(gh<_i32.SaveTalkingThreshold>()));
  gh.factory<_i34.SettingsBloc>(() => _i34.SettingsBloc(
        gh<_i25.StreamSettingsEffect>(),
        gh<_i33.SetTalkingThresholdEffect>(),
      ));
  gh.factory<_i35.StreamMascot>(
      () => _i35.StreamMascot(gh<_i30.MascotsRepository>()));
  gh.factory<_i36.StreamMascotEffect>(
      () => _i36.StreamMascotEffect(gh<_i35.StreamMascot>()));
  gh.factory<_i13.AddMascot>(() => _i13.AddMascot(
        gh<_i30.MascotsRepository>(),
        gh<_i29.ExpressionsRepository>(),
        gh<_i21.SettingsRepository>(),
        gh<_i7.Logger<_i13.AddMascot>>(),
      ));
  gh.factory<_i37.CameraControllerBloc>(
      () => _i37.CameraControllerBloc(gh<_i10.LoadCameraController>()));
  gh.factory<_i38.ExpressionAnimationService>(() =>
      _i38.ExpressionAnimationServiceImpl(gh<_i27.ExpressionTriggerFactory>()));
  gh.factory<_i39.GetMascot>(
      () => _i39.GetMascot(gh<_i30.MascotsRepository>()));
  gh.factory<_i40.MascotUpdatedEffect>(
      () => _i40.MascotUpdatedEffect(gh<_i38.ExpressionAnimationService>()));
  gh.factory<_i41.SaveMascotEffect>(
      () => _i41.SaveMascotEffect(gh<_i13.AddMascot>()));
  gh.factory<_i42.CreateMascotBloc>(
      () => _i42.CreateMascotBloc(gh<_i41.SaveMascotEffect>()));
  gh.factory<_i43.MascotAnimatorBloc>(() => _i43.MascotAnimatorBloc(
        gh<_i36.StreamMascotEffect>(),
        gh<_i40.MascotUpdatedEffect>(),
      ));
  return getIt;
}
