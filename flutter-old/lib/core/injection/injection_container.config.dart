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
import '../../features/camera/device/services/camera_controller_context_impl.dart'
    as _i17;
import '../../features/camera/device/services/camera_controller_factory.dart'
    as _i6;
import '../../features/camera/device/services/camera_service_impl.dart' as _i14;
import '../../features/camera/domain/services/camera_controller_context.dart'
    as _i43;
import '../../features/camera/domain/services/camera_controller_factory.dart'
    as _i5;
import '../../features/camera/domain/services/camera_service.dart' as _i32;
import '../../features/camera/presentation/bloc/camera_controller_bloc.dart'
    as _i48;
import '../../features/camera/presentation/bloc/effects/load_camera_controller.dart'
    as _i16;
import '../../features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i34;
import '../../features/expressions/data/models/expression_mapper.dart' as _i7;
import '../../features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i13;
import '../../features/expressions/domain/repositories/expressions_repository.dart'
    as _i35;
import '../../features/expressions/domain/services/animation/expression_animation_service.dart'
    as _i44;
import '../../features/expressions/domain/services/animation/expression_trigger_factory.dart'
    as _i33;
import '../../features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i19;
import '../../features/mascot/data/models/mascot_mapper.dart' as _i18;
import '../../features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i15;
import '../../features/mascot/domain/repositories/mascots_repository.dart'
    as _i36;
import '../../features/mascot/domain/usecases/add_mascot.dart' as _i10;
import '../../features/mascot/domain/usecases/get_mascot.dart' as _i45;
import '../../features/mascot/domain/usecases/stream_mascot.dart' as _i41;
import '../../features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart'
    as _i49;
import '../../features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart'
    as _i47;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart'
    as _i46;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart'
    as _i42;
import '../../features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart'
    as _i50;
import '../../features/microphone/device/microphone.dart' as _i20;
import '../../features/microphone/device/services/microphone_context_impl.dart'
    as _i12;
import '../../features/microphone/device/web/web_microphone.dart' as _i11;
import '../../features/microphone/domain/services/microphone_context.dart'
    as _i22;
import '../../features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i28;
import '../../features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart'
    as _i31;
import '../../features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart'
    as _i37;
import '../../features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i24;
import '../../features/settings/data/models/record_settings_mapper.dart'
    as _i23;
import '../../features/settings/data/models/settings_mapper.dart' as _i25;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i27;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i26;
import '../../features/settings/domain/usecases/save_talking_threshold.dart'
    as _i38;
import '../../features/settings/domain/usecases/stream_settings.dart' as _i29;
import '../../features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart'
    as _i39;
import '../../features/settings/presentation/bloc/effects/stream_settings_effect.dart'
    as _i30;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i40;
import '../data/indexed_db/indexed_db_data_source.dart' as _i8;
import '../device/web/js_interop/web_audio/audio_context.dart' as _i4;
import '../device/web/js_interop/web_audio/web_audio.dart' as _i21;
import '../utils/logger.dart' as _i9;

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
  gh.factory<_i5.CameraControllerFactory>(
      () => _i6.CameraControllerFactoryImpl());
  gh.lazySingleton<_i7.ExpressionMapper>(() => _i7.ExpressionMapperImpl());
  gh.lazySingleton<_i8.IndexDbSettings>(() => _i8.IndexDbSettings());
  gh.lazySingleton<_i8.IndexedDbFactory>(() => _i8.IndexedDbFactory());
  gh.factory<_i9.Logger<_i10.AddMascot>>(() => _i10.AddMascotLogger());
  gh.factory<_i9.Logger<_i11.WebMicrophone>>(
      () => _i11.MascotMicrophoneLogger());
  gh.factory<_i9.Logger<_i12.MicrophoneContextImpl>>(
      () => _i12.MicrophoneContextImplLogger());
  gh.factory<_i9.Logger<_i13.ExpressionsRepositoryImpl>>(
      () => _i13.ExpressionsRepositoryLogger());
  gh.factory<_i9.Logger<_i14.CameraServiceImpl>>(
      () => _i14.CameraServiceImplLogger());
  gh.factory<_i9.Logger<_i15.MascotsRepositoryImpl>>(
      () => _i15.MascotRepositoryLogger());
  gh.factory<_i9.Logger<_i16.LoadCameraController>>(
      () => _i16.LoadCameraLogger());
  gh.factory<_i9.Logger<_i17.CameraControllerContextImpl>>(
      () => _i17.CameraControllerContextImplLogger());
  gh.lazySingleton<_i18.MascotMapper>(
      () => _i18.MascotMapperImpl(gh<_i7.ExpressionMapper>()));
  gh.lazySingleton<_i19.MascotsIndexedDbDataSource>(
      () => _i19.MascotsIndexedDbDataSource(
            gh<_i8.IndexedDbFactory>(),
            gh<_i8.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i20.Microphone>(() => _i11.WebMicrophone(
        gh<_i21.AudioContext>(),
        gh<_i9.Logger<_i11.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i22.MicrophoneContext>(() => _i12.MicrophoneContextImpl(
        gh<_i20.Microphone>(),
        gh<_i9.Logger<_i12.MicrophoneContextImpl>>(),
      ));
  gh.lazySingleton<_i23.RecordSettingsMapper>(
      () => _i23.RecordSettingsMapperImpl());
  gh.lazySingleton<_i24.SettingsIndexedDbDataSource>(
      () => _i24.SettingsIndexedDbDataSource(
            gh<_i8.IndexedDbFactory>(),
            gh<_i8.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i25.SettingsMapper>(
      () => _i25.SettingsMapperImpl(gh<_i23.RecordSettingsMapper>()));
  gh.factory<_i26.SettingsRepository>(() => _i27.SettingsRepositoryImpl(
        gh<_i24.SettingsIndexedDbDataSource>(),
        gh<_i25.SettingsMapper>(),
      ));
  gh.factory<_i28.StreamMicrophoneVolume>(
      () => _i28.StreamMicrophoneVolume(gh<_i22.MicrophoneContext>()));
  gh.factory<_i29.StreamSettings>(
      () => _i29.StreamSettings(gh<_i26.SettingsRepository>()));
  gh.factory<_i30.StreamSettingsEffect>(
      () => _i30.StreamSettingsEffect(gh<_i29.StreamSettings>()));
  gh.factory<_i31.StreamVolumeEffect>(
      () => _i31.StreamVolumeEffect(gh<_i28.StreamMicrophoneVolume>()));
  gh.lazySingleton<_i32.CameraService>(
      () => _i14.CameraServiceImpl(gh<_i9.Logger<_i14.CameraServiceImpl>>()));
  gh.factory<_i33.ExpressionTriggerFactory>(() => _i33.ExpressionTriggerFactory(
        gh<_i26.SettingsRepository>(),
        gh<_i28.StreamMicrophoneVolume>(),
      ));
  gh.lazySingleton<_i34.ExpressionsIndexedDbDataSource>(
      () => _i34.ExpressionsIndexedDbDataSource(
            gh<_i8.IndexedDbFactory>(),
            gh<_i8.IndexDbSettings>(),
          ));
  gh.factory<_i35.ExpressionsRepository>(() => _i13.ExpressionsRepositoryImpl(
        gh<_i34.ExpressionsIndexedDbDataSource>(),
        gh<_i7.ExpressionMapper>(),
        gh<_i9.Logger<_i13.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i36.MascotsRepository>(() => _i15.MascotsRepositoryImpl(
        gh<_i19.MascotsIndexedDbDataSource>(),
        gh<_i34.ExpressionsIndexedDbDataSource>(),
        gh<_i18.MascotMapper>(),
        gh<_i9.Logger<_i15.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i37.MicrophoneVolumeBloc>(
      () => _i37.MicrophoneVolumeBloc(gh<_i31.StreamVolumeEffect>()));
  gh.factory<_i38.SaveTalkingThreshold>(
      () => _i38.SaveTalkingThreshold(gh<_i26.SettingsRepository>()));
  gh.factory<_i39.SetTalkingThresholdEffect>(
      () => _i39.SetTalkingThresholdEffect(gh<_i38.SaveTalkingThreshold>()));
  gh.factory<_i40.SettingsBloc>(() => _i40.SettingsBloc(
        gh<_i30.StreamSettingsEffect>(),
        gh<_i39.SetTalkingThresholdEffect>(),
      ));
  gh.factory<_i41.StreamMascot>(
      () => _i41.StreamMascot(gh<_i36.MascotsRepository>()));
  gh.factory<_i42.StreamMascotEffect>(
      () => _i42.StreamMascotEffect(gh<_i41.StreamMascot>()));
  gh.factory<_i10.AddMascot>(() => _i10.AddMascot(
        gh<_i36.MascotsRepository>(),
        gh<_i35.ExpressionsRepository>(),
        gh<_i26.SettingsRepository>(),
        gh<_i9.Logger<_i10.AddMascot>>(),
      ));
  gh.factory<_i43.CameraControllerContext>(
      () => _i17.CameraControllerContextImpl(
            gh<_i32.CameraService>(),
            gh<_i5.CameraControllerFactory>(),
            gh<_i9.Logger<_i17.CameraControllerContextImpl>>(),
          ));
  gh.factory<_i44.ExpressionAnimationService>(() =>
      _i44.ExpressionAnimationServiceImpl(gh<_i33.ExpressionTriggerFactory>()));
  gh.factory<_i45.GetMascot>(
      () => _i45.GetMascot(gh<_i36.MascotsRepository>()));
  gh.factory<_i16.LoadCameraController>(() => _i16.LoadCameraController(
        gh<_i43.CameraControllerContext>(),
        gh<_i9.Logger<_i16.LoadCameraController>>(),
      ));
  gh.factory<_i46.MascotUpdatedEffect>(
      () => _i46.MascotUpdatedEffect(gh<_i44.ExpressionAnimationService>()));
  gh.factory<_i47.SaveMascotEffect>(
      () => _i47.SaveMascotEffect(gh<_i10.AddMascot>()));
  gh.factory<_i48.CameraControllerBloc>(
      () => _i48.CameraControllerBloc(gh<_i16.LoadCameraController>()));
  gh.factory<_i49.CreateMascotBloc>(
      () => _i49.CreateMascotBloc(gh<_i47.SaveMascotEffect>()));
  gh.factory<_i50.MascotAnimatorBloc>(() => _i50.MascotAnimatorBloc(
        gh<_i42.StreamMascotEffect>(),
        gh<_i46.MascotUpdatedEffect>(),
      ));
  return getIt;
}
