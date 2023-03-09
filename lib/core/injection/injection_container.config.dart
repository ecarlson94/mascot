// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/collection_adapter.dart' as _i11;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/expressions/data/datasources/expressions_local_data_source.dart'
    as _i12;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i8;
import 'package:mascot/features/expressions/data/models/map_expression_to_expression_model.dart'
    as _i13;
import 'package:mascot/features/expressions/data/models/map_image_to_image_model.dart'
    as _i5;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i21;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i20;
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart'
    as _i15;
import 'package:mascot/features/mascot/data/models/map_mascot_to_mascot_model.dart'
    as _i14;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i9;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i23;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i22;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i27;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i24;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i26;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i28;
import 'package:mascot/features/settings/data/datasources/settings_local_data_source.dart'
    as _i16;
import 'package:mascot/features/settings/data/models/map_settings_to_settings_model.dart'
    as _i6;
import 'package:mascot/features/settings/data/models/settings_model.dart'
    as _i10;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i18;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i17;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i19;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i25;

import '../../features/expressions/data/datasources/expressions_collection.dart'
    as _i29;
import '../../features/mascot/data/datasources/mascots_collection.dart' as _i30;
import '../../features/settings/data/repositories/settings_collection.dart'
    as _i32;
import 'db_configuration.dart' as _i31;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final hiveSingleton = _$HiveSingleton();
  final hiveExpressionsCollection = _$HiveExpressionsCollection();
  final hiveMascotsCollection = _$HiveMascotsCollection();
  final hiveSettingsCollection = _$HiveSettingsCollection();
  final expressionsCollectionAdapter = _$ExpressionsCollectionAdapter();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  final settingsCollectionAdapter = _$SettingsCollectionAdapter();
  gh.factory<_i3.ConvertXfileToImage>(() => _i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.factory<_i5.MapImageToImageModel>(() => _i5.MapImageToImageModel());
  gh.factory<_i6.MapSettingsToSettingsModel>(
      () => _i6.MapSettingsToSettingsModel());
  await gh.singletonAsync<_i7.Box<_i8.ExpressionModel>>(
    () => hiveExpressionsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i9.MascotModel>>(
    () => hiveMascotsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i10.SettingsModel>>(
    () => hiveSettingsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  gh.factory<_i11.CollectionAdapter<_i8.ExpressionModel>>(() =>
      expressionsCollectionAdapter.create(gh<_i7.Box<_i8.ExpressionModel>>()));
  gh.factory<_i11.CollectionAdapter<_i9.MascotModel>>(
      () => mascotsCollectionAdapter.create(gh<_i7.Box<_i9.MascotModel>>()));
  gh.factory<_i11.CollectionAdapter<_i10.SettingsModel>>(() =>
      settingsCollectionAdapter.create(gh<_i7.Box<_i10.SettingsModel>>()));
  gh.factory<_i12.ExpressionsLocalDataSource>(() =>
      _i12.ImagesLocalDataSourceImpl(
          gh<_i11.CollectionAdapter<_i8.ExpressionModel>>()));
  gh.factory<_i13.MapExpressionToExpressionModel>(() =>
      _i13.MapExpressionToExpressionModel(gh<_i5.MapImageToImageModel>()));
  gh.factory<_i14.MapMascotToMascotModel>(() =>
      _i14.MapMascotToMascotModel(gh<_i13.MapExpressionToExpressionModel>()));
  gh.factory<_i15.MascotsLocalDataSource>(() => _i15.MascotsLocalDataSourceImpl(
      gh<_i11.CollectionAdapter<_i9.MascotModel>>()));
  gh.factory<_i16.SettingsLocalDataSource>(() =>
      _i16.SettingsLocalDataSourceImpl(
          gh<_i11.CollectionAdapter<_i10.SettingsModel>>()));
  gh.factory<_i17.SettingsRepository>(() => _i18.SettingsRepositoryImpl(
        gh<_i16.SettingsLocalDataSource>(),
        gh<_i6.MapSettingsToSettingsModel>(),
      ));
  gh.factory<_i19.StreamSettings>(
      () => _i19.StreamSettings(gh<_i17.SettingsRepository>()));
  gh.factory<_i20.ExpressionsRepository>(() => _i21.ExpressionsRepositoryImpl(
        gh<_i12.ExpressionsLocalDataSource>(),
        gh<_i13.MapExpressionToExpressionModel>(),
      ));
  gh.factory<_i22.MascotsRepository>(() => _i23.MascotsRepositoryImpl(
        gh<_i15.MascotsLocalDataSource>(),
        gh<_i20.ExpressionsRepository>(),
        gh<_i14.MapMascotToMascotModel>(),
      ));
  gh.factory<_i24.SaveMascot>(
      () => _i24.SaveMascot(gh<_i22.MascotsRepository>()));
  gh.factory<_i25.SettingsBloc>(
      () => _i25.SettingsBloc(gh<_i19.StreamSettings>()));
  gh.factory<_i26.StreamMascot>(
      () => _i26.StreamMascot(gh<_i22.MascotsRepository>()));
  gh.factory<_i27.GetMascot>(
      () => _i27.GetMascot(gh<_i22.MascotsRepository>()));
  gh.factory<_i28.CreateMascotBloc>(() => _i28.CreateMascotBloc(
        gh<_i3.ConvertXfileToImage>(),
        gh<_i24.SaveMascot>(),
        gh<_i27.GetMascot>(),
      ));
  return getIt;
}

class _$HiveExpressionsCollection extends _i29.HiveExpressionsCollection {}

class _$ExpressionsCollectionAdapter
    extends _i29.ExpressionsCollectionAdapter {}

class _$HiveMascotsCollection extends _i30.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i30.MascotsCollectionAdapter {}

class _$HiveSingleton extends _i31.HiveSingleton {}

class _$HiveSettingsCollection extends _i32.HiveSettingsCollection {}

class _$SettingsCollectionAdapter extends _i32.SettingsCollectionAdapter {}
