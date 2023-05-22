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
import '../../features/camera/device/services/camera_context_impl.dart' as _i13;
import '../../features/camera/domain/services/camera_context.dart' as _i29;
import '../../features/camera/presentation/bloc/camera_controller_bloc.dart'
    as _i40;
import '../../features/camera/presentation/bloc/effects/load_camera_controller.dart'
    as _i12;
import '../../features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart'
    as _i31;
import '../../features/expressions/data/models/expression_mapper.dart' as _i5;
import '../../features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i11;
import '../../features/expressions/domain/repositories/expressions_repository.dart'
    as _i32;
import '../../features/expressions/domain/services/animation/expression_animation_service.dart'
    as _i41;
import '../../features/expressions/domain/services/animation/expression_trigger_factory.dart'
    as _i30;
import '../../features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart'
    as _i16;
import '../../features/mascot/data/models/mascot_mapper.dart' as _i15;
import '../../features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i10;
import '../../features/mascot/domain/repositories/mascots_repository.dart'
    as _i33;
import '../../features/mascot/domain/usecases/add_mascot.dart' as _i9;
import '../../features/mascot/domain/usecases/get_mascot.dart' as _i42;
import '../../features/mascot/domain/usecases/stream_mascot.dart' as _i38;
import '../../features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart'
    as _i45;
import '../../features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart'
    as _i44;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart'
    as _i43;
import '../../features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart'
    as _i39;
import '../../features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart'
    as _i46;
import '../../features/microphone/device/microphone.dart' as _i17;
import '../../features/microphone/device/services/microphone_context_impl.dart'
    as _i8;
import '../../features/microphone/device/web/web_microphone.dart' as _i14;
import '../../features/microphone/domain/services/microphone_context.dart'
    as _i19;
import '../../features/microphone/domain/usecases/stream_microphone_volume.dart'
    as _i25;
import '../../features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart'
    as _i28;
import '../../features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart'
    as _i34;
import '../../features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart'
    as _i21;
import '../../features/settings/data/models/record_settings_mapper.dart'
    as _i20;
import '../../features/settings/data/models/settings_mapper.dart' as _i22;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i24;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i23;
import '../../features/settings/domain/usecases/save_talking_threshold.dart'
    as _i35;
import '../../features/settings/domain/usecases/stream_settings.dart' as _i26;
import '../../features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart'
    as _i36;
import '../../features/settings/presentation/bloc/effects/stream_settings_effect.dart'
    as _i27;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i37;
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
  gh.factory<_i7.Logger<_i8.MicrophoneContextImpl>>(
      () => _i8.MicrophoneContextImplLogger());
  gh.factory<_i7.Logger<_i9.AddMascot>>(() => _i9.AddMascotLogger());
  gh.factory<_i7.Logger<_i10.MascotsRepositoryImpl>>(
      () => _i10.MascotRepositoryLogger());
  gh.factory<_i7.Logger<_i11.ExpressionsRepositoryImpl>>(
      () => _i11.ExpressionsRepositoryLogger());
  gh.factory<_i7.Logger<_i12.LoadCameraController>>(
      () => _i12.LoadCameraLogger());
  gh.factory<_i7.Logger<_i13.CameraContextImpl>>(
      () => _i13.CameraContextImplLogger());
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
  gh.lazySingleton<_i19.MicrophoneContext>(() => _i8.MicrophoneContextImpl(
        gh<_i17.Microphone>(),
        gh<_i7.Logger<_i8.MicrophoneContextImpl>>(),
      ));
  gh.lazySingleton<_i20.RecordSettingsMapper>(
      () => _i20.RecordSettingsMapperImpl());
  gh.lazySingleton<_i21.SettingsIndexedDbDataSource>(
      () => _i21.SettingsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.lazySingleton<_i22.SettingsMapper>(
      () => _i22.SettingsMapperImpl(gh<_i20.RecordSettingsMapper>()));
  gh.factory<_i23.SettingsRepository>(() => _i24.SettingsRepositoryImpl(
        gh<_i21.SettingsIndexedDbDataSource>(),
        gh<_i22.SettingsMapper>(),
      ));
  gh.factory<_i25.StreamMicrophoneVolume>(
      () => _i25.StreamMicrophoneVolume(gh<_i19.MicrophoneContext>()));
  gh.factory<_i26.StreamSettings>(
      () => _i26.StreamSettings(gh<_i23.SettingsRepository>()));
  gh.factory<_i27.StreamSettingsEffect>(
      () => _i27.StreamSettingsEffect(gh<_i26.StreamSettings>()));
  gh.factory<_i28.StreamVolumeEffect>(
      () => _i28.StreamVolumeEffect(gh<_i25.StreamMicrophoneVolume>()));
  gh.lazySingleton<_i29.CameraContext>(
      () => _i13.CameraContextImpl(gh<_i7.Logger<_i13.CameraContextImpl>>()));
  gh.factory<_i30.ExpressionTriggerFactory>(() => _i30.ExpressionTriggerFactory(
        gh<_i23.SettingsRepository>(),
        gh<_i25.StreamMicrophoneVolume>(),
      ));
  gh.lazySingleton<_i31.ExpressionsIndexedDbDataSource>(
      () => _i31.ExpressionsIndexedDbDataSource(
            gh<_i6.IndexedDbFactory>(),
            gh<_i6.IndexDbSettings>(),
          ));
  gh.factory<_i32.ExpressionsRepository>(() => _i11.ExpressionsRepositoryImpl(
        gh<_i31.ExpressionsIndexedDbDataSource>(),
        gh<_i5.ExpressionMapper>(),
        gh<_i7.Logger<_i11.ExpressionsRepositoryImpl>>(),
      ));
  gh.factory<_i12.LoadCameraController>(() => _i12.LoadCameraController(
        gh<_i29.CameraContext>(),
        gh<_i7.Logger<_i12.LoadCameraController>>(),
      ));
  gh.factory<_i33.MascotsRepository>(() => _i10.MascotsRepositoryImpl(
        gh<_i16.MascotsIndexedDbDataSource>(),
        gh<_i31.ExpressionsIndexedDbDataSource>(),
        gh<_i15.MascotMapper>(),
        gh<_i7.Logger<_i10.MascotsRepositoryImpl>>(),
      ));
  gh.factory<_i34.MicrophoneVolumeBloc>(
      () => _i34.MicrophoneVolumeBloc(gh<_i28.StreamVolumeEffect>()));
  gh.factory<_i35.SaveTalkingThreshold>(
      () => _i35.SaveTalkingThreshold(gh<_i23.SettingsRepository>()));
  gh.factory<_i36.SetTalkingThresholdEffect>(
      () => _i36.SetTalkingThresholdEffect(gh<_i35.SaveTalkingThreshold>()));
  gh.factory<_i37.SettingsBloc>(() => _i37.SettingsBloc(
        gh<_i27.StreamSettingsEffect>(),
        gh<_i36.SetTalkingThresholdEffect>(),
      ));
  gh.factory<_i38.StreamMascot>(
      () => _i38.StreamMascot(gh<_i33.MascotsRepository>()));
  gh.factory<_i39.StreamMascotEffect>(
      () => _i39.StreamMascotEffect(gh<_i38.StreamMascot>()));
  gh.factory<_i9.AddMascot>(() => _i9.AddMascot(
        gh<_i33.MascotsRepository>(),
        gh<_i32.ExpressionsRepository>(),
        gh<_i23.SettingsRepository>(),
        gh<_i7.Logger<_i9.AddMascot>>(),
      ));
  gh.factory<_i40.CameraControllerBloc>(
      () => _i40.CameraControllerBloc(gh<_i12.LoadCameraController>()));
  gh.factory<_i41.ExpressionAnimationService>(() =>
      _i41.ExpressionAnimationServiceImpl(gh<_i30.ExpressionTriggerFactory>()));
  gh.factory<_i42.GetMascot>(
      () => _i42.GetMascot(gh<_i33.MascotsRepository>()));
  gh.factory<_i43.MascotUpdatedEffect>(
      () => _i43.MascotUpdatedEffect(gh<_i41.ExpressionAnimationService>()));
  gh.factory<_i44.SaveMascotEffect>(
      () => _i44.SaveMascotEffect(gh<_i9.AddMascot>()));
  gh.factory<_i45.CreateMascotBloc>(
      () => _i45.CreateMascotBloc(gh<_i44.SaveMascotEffect>()));
  gh.factory<_i46.MascotAnimatorBloc>(() => _i46.MascotAnimatorBloc(
        gh<_i39.StreamMascotEffect>(),
        gh<_i43.MascotUpdatedEffect>(),
      ));
  return getIt;
}
