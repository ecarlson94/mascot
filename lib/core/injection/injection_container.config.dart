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
import '../../features/camera/device/services/camera_context_impl.dart' as _i8;
import '../../features/camera/domain/services/camera_context.dart' as _i28;
import '../../features/camera/presentation/bloc/camera_controller_bloc.dart'
    as _i39;
import '../../features/camera/presentation/bloc/effects/load_camera_controller.dart'
    as _i12;
import '../../features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i30;
import '../../features/expressions/data/models/expression_mapper.dart' as _i5;
import '../../features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i10;
import '../../features/expressions/domain/repositories/expressions_repository.dart'
    as _i31;
import '../../features/expressions/domain/services/animation/expression_animation_service.dart'
    as _i40;
import '../../features/expressions/domain/services/animation/expression_trigger_factory.dart'
    as _i29;
import '../../features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i16;
import '../../features/mascot/data/models/mascot_mapper.dart' as _i15;
import '../../features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i11;
import '../../features/mascot/domain/repositories/mascots_repository.dart'
    as _i32;
import '../../features/mascot/domain/usecases/add_mascot.dart' as _i9;
import '../../features/mascot/domain/usecases/get_mascot.dart' as _i41;
import '../../features/mascot/domain/usecases/stream_mascot.dart' as _i37;
import '../../features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart'
    as _i44;
import '../../features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart'
    as _i43;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart'
    as _i42;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart'
    as _i38;
import '../../features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart'
    as _i45;
import '../../features/microphone/device/microphone.dart' as _i17;
import '../../features/microphone/device/services/microphone_context_impl.dart'
    as _i13;
import '../../features/microphone/device/web/web_microphone.dart' as _i14;
import '../../features/microphone/domain/services/microphone_context.dart'
    as _i19;
import '../../features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i24;
import '../../features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart'
    as _i27;
import '../../features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart'
    as _i33;
import '../../features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i20;
import '../../features/settings/data/models/settings_mapper.dart' as _i21;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i23;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i22;
import '../../features/settings/domain/usecases/save_talking_threshold.dart'
    as _i34;
import '../../features/settings/domain/usecases/stream_settings.dart' as _i25;
import '../../features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart'
    as _i35;
import '../../features/settings/presentation/bloc/effects/stream_settings_effect.dart'
    as _i26;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i36;
import '../data/indexed_db/indexed_db_data_source.dart' as _i6;
import '../device/web/js_interop/web_audio/audio_context.dart' as _i4;
import '../device/web/js_interop/web_audio/web_audio.dart' as _i18;
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
  gh.factory<_i7.Logger<_i8.CameraContextImpl>>(
      () => _i8.CameraContextImplLogger());
  gh.factory<_i7.Logger<_i9.AddMascot>>(() => _i9.AddMascotLogger());
  gh.factory<_i7.Logger<_i10.ExpressionsRepositoryImpl>>(
      () => _i10.ExpressionsRepositoryLogger());
  gh.factory<_i7.Logger<_i11.MascotsRepositoryImpl>>(
      () => _i11.MascotRepositoryLogger());
  gh.factory<_i7.Logger<_i12.LoadCameraController>>(
      () => _i12.LoadCameraLogger());
  gh.factory<_i7.Logger<_i13.MicrophoneContextImpl>>(
      () => _i13.MicrophoneContextImplLogger());
  gh.factory<_i7.Logger<_i14.WebMicrophone>>(
      () => _i14.MascotMicrophoneLogger());
  gh.lazySingleton<_i15.MascotMapper>(
      () => _i15.MascotMapperImpl(gh<_i5.ExpressionMapper>()));
  gh.lazySingleton<_i16.MascotsIndexedDbDataSource>(
      () => _i16.MascotsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i17.Microphone>(() => _i14.WebMicrophone(
        gh<_i18.AudioContext>(),
        gh<_i7.Logger<_i14.WebMicrophone>>(),
      ));
  gh.lazySingleton<_i19.MicrophoneContext>(() => _i13.MicrophoneContextImpl(
        gh<_i17.Microphone>(),
        gh<_i7.Logger<_i13.MicrophoneContextImpl>>(),
      ));
  gh.lazySingleton<_i20.SettingsIndexedDbDataSource>(
      () => _i20.SettingsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i21.SettingsMapper>(() => _i21.SettingsMapperImpl());
  gh.factory<_i22.SettingsRepository>(() => _i23.SettingsRepositoryImpl(
        gh<_i20.SettingsIndexedDbDataSource>(),
        gh<_i21.SettingsMapper>(),
      ));
  gh.factory<_i24.StreamMicrophoneVolume>(
      () => _i24.StreamMicrophoneVolume(gh<_i19.MicrophoneContext>()));
  gh.factory<_i25.StreamSettings>(
      () => _i25.StreamSettings(gh<_i22.SettingsRepository>()));
  gh.factory<_i26.StreamSettingsEffect>(
      () => _i26.StreamSettingsEffect(gh<_i25.StreamSettings>()));
  gh.factory<_i27.StreamVolumeEffect>(
      () => _i27.StreamVolumeEffect(gh<_i24.StreamMicrophoneVolume>()));
  gh.lazySingleton<_i28.CameraContext>(
      () => _i8.CameraContextImpl(gh<_i7.Logger<_i8.CameraContextImpl>>()));
  gh.factory<_i29.ExpressionTriggerFactory>(() => _i29.ExpressionTriggerFactory(
        gh<_i22.SettingsRepository>(),
        gh<_i24.StreamMicrophoneVolume>(),
      ));
  gh.lazySingleton<_i30.ExpressionsIndexedDbDataSource>(
      () => _i30.ExpressionsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.factory<_i31.ExpressionsRepository>(() => _i10.ExpressionsRepositoryImpl(
        gh<_i30.ExpressionsIndexedDbDataSource>(),
        gh<_i5.ExpressionMapper>(),
        gh<_i7.Logger<_i10.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i12.LoadCameraController>(() => _i12.LoadCameraController(
        gh<_i28.CameraContext>(),
        gh<_i7.Logger<_i12.LoadCameraController>>(),
      ));
  gh.factory<_i32.MascotsRepository>(() => _i11.MascotsRepositoryImpl(
        gh<_i16.MascotsIndexedDbDataSource>(),
        gh<_i30.ExpressionsIndexedDbDataSource>(),
        gh<_i15.MascotMapper>(),
        gh<_i7.Logger<_i11.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i33.MicrophoneVolumeBloc>(
      () => _i33.MicrophoneVolumeBloc(gh<_i27.StreamVolumeEffect>()));
  gh.factory<_i34.SaveTalkingThreshold>(
      () => _i34.SaveTalkingThreshold(gh<_i22.SettingsRepository>()));
  gh.factory<_i35.SetTalkingThresholdEffect>(
      () => _i35.SetTalkingThresholdEffect(gh<_i34.SaveTalkingThreshold>()));
  gh.factory<_i36.SettingsBloc>(() => _i36.SettingsBloc(
        gh<_i26.StreamSettingsEffect>(),
        gh<_i35.SetTalkingThresholdEffect>(),
      ));
  gh.factory<_i37.StreamMascot>(
      () => _i37.StreamMascot(gh<_i32.MascotsRepository>()));
  gh.factory<_i38.StreamMascotEffect>(
      () => _i38.StreamMascotEffect(gh<_i37.StreamMascot>()));
  gh.factory<_i9.AddMascot>(() => _i9.AddMascot(
        gh<_i32.MascotsRepository>(),
        gh<_i31.ExpressionsRepository>(),
        gh<_i22.SettingsRepository>(),
        gh<_i7.Logger<_i9.AddMascot>>(),
      ));
  gh.factory<_i39.CameraControllerBloc>(
      () => _i39.CameraControllerBloc(gh<_i12.LoadCameraController>()));
  gh.factory<_i40.ExpressionAnimationService>(() =>
      _i40.ExpressionAnimationServiceImpl(gh<_i29.ExpressionTriggerFactory>()));
  gh.factory<_i41.GetMascot>(
      () => _i41.GetMascot(gh<_i32.MascotsRepository>()));
  gh.factory<_i42.MascotUpdatedEffect>(
      () => _i42.MascotUpdatedEffect(gh<_i40.ExpressionAnimationService>()));
  gh.factory<_i43.SaveMascotEffect>(
      () => _i43.SaveMascotEffect(gh<_i9.AddMascot>()));
  gh.factory<_i44.CreateMascotBloc>(
      () => _i44.CreateMascotBloc(gh<_i43.SaveMascotEffect>()));
  gh.factory<_i45.MascotAnimatorBloc>(() => _i45.MascotAnimatorBloc(
        gh<_i38.StreamMascotEffect>(),
        gh<_i42.MascotUpdatedEffect>(),
      ));
  return getIt;
}
