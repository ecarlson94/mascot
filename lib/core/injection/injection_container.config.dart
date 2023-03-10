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
import 'package:mascot/core/data/hive/hive_collection_adapter.dart' as _i13;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/expressions/data/datasources/expressions_local_data_source.dart'
    as _i12;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i10;
import 'package:mascot/features/expressions/data/models/map_expression_to_expression_model.dart'
    as _i14;
import 'package:mascot/features/expressions/data/models/map_image_to_image_model.dart'
    as _i5;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i22;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i21;
import 'package:mascot/features/mascot/data/datasources/hive/mascots_hive_data_source.dart'
    as _i16;
import 'package:mascot/features/mascot/data/models/map_mascot_to_mascot_model.dart'
    as _i15;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i8;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i24;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i23;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i28;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i25;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i27;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i30;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i29;
import 'package:mascot/features/settings/data/datasources/settings_local_data_source.dart'
    as _i17;
import 'package:mascot/features/settings/data/models/map_settings_to_settings_model.dart'
    as _i6;
import 'package:mascot/features/settings/data/models/settings_model.dart'
    as _i9;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i19;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i18;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i20;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i26;

import '../../features/expressions/data/datasources/expressions_collection.dart'
    as _i32;
import '../../features/mascot/data/datasources/hive/hive_collection.dart'
    as _i34;
import '../../features/settings/data/datasources/settings_collection.dart'
    as _i33;
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
  final hiveMascotsCollection = _$HiveMascotsCollection();
  final hiveSettingsCollection = _$HiveSettingsCollection();
  final hiveExpressionsCollection = _$HiveExpressionsCollection();
  final settingsHiveCollectionAdapter = _$SettingsHiveCollectionAdapter();
  final expressionsCollectionAdapter = _$ExpressionsCollectionAdapter();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  gh.factory<_i3.ConvertXfileToImage>(() => _i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.factory<_i5.MapImageToImageModel>(() => _i5.MapImageToImageModel());
  gh.factory<_i6.MapSettingsToSettingsModel>(
      () => _i6.MapSettingsToSettingsModel());
  await gh.singletonAsync<_i7.Box<_i8.MascotModel>>(
    () => hiveMascotsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i9.SettingsModel>>(
    () => hiveSettingsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i10.ExpressionModel>>(
    () => hiveExpressionsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  gh.factory<_i11.CollectionAdapter<_i9.SettingsModel>>(() =>
      settingsHiveCollectionAdapter.create(gh<_i7.Box<_i9.SettingsModel>>()));
  gh.factory<_i11.CollectionAdapter<_i10.ExpressionModel>>(() =>
      expressionsCollectionAdapter.create(gh<_i7.Box<_i10.ExpressionModel>>()));
  gh.factory<_i12.ExpressionsLocalDataSource>(() =>
      _i12.ImagesLocalDataSourceImpl(
          gh<_i11.CollectionAdapter<_i10.ExpressionModel>>()));
  gh.factory<_i13.HiveCollectionAdapter<_i8.MascotModel>>(
      () => mascotsCollectionAdapter.create(gh<_i7.Box<_i8.MascotModel>>()));
  gh.factory<_i14.MapExpressionToExpressionModel>(() =>
      _i14.MapExpressionToExpressionModel(gh<_i5.MapImageToImageModel>()));
  gh.factory<_i15.MapMascotToMascotModel>(() =>
      _i15.MapMascotToMascotModel(gh<_i14.MapExpressionToExpressionModel>()));
  gh.factory<_i16.MascotsHiveDataSource>(() => _i16.MascotsHiveDataSourceImpl(
      gh<_i13.HiveCollectionAdapter<_i8.MascotModel>>()));
  gh.factory<_i17.SettingsLocalDataSource>(() =>
      _i17.SettingsLocalDataSourceImpl(
          gh<_i11.CollectionAdapter<_i9.SettingsModel>>()));
  gh.factory<_i18.SettingsRepository>(() => _i19.SettingsRepositoryImpl(
        gh<_i17.SettingsLocalDataSource>(),
        gh<_i6.MapSettingsToSettingsModel>(),
      ));
  gh.factory<_i20.StreamSettings>(
      () => _i20.StreamSettings(gh<_i18.SettingsRepository>()));
  gh.factory<_i21.ExpressionsRepository>(() => _i22.ExpressionsRepositoryImpl(
        gh<_i12.ExpressionsLocalDataSource>(),
        gh<_i14.MapExpressionToExpressionModel>(),
      ));
  gh.factory<_i23.MascotsRepository>(() => _i24.MascotsRepositoryImpl(
        gh<_i16.MascotsHiveDataSource>(),
        gh<_i21.ExpressionsRepository>(),
        gh<_i18.SettingsRepository>(),
        gh<_i15.MapMascotToMascotModel>(),
      ));
  gh.factory<_i25.SaveMascot>(
      () => _i25.SaveMascot(gh<_i23.MascotsRepository>()));
  gh.factory<_i26.SettingsBloc>(
      () => _i26.SettingsBloc(gh<_i20.StreamSettings>()));
  gh.factory<_i27.StreamMascot>(
      () => _i27.StreamMascot(gh<_i23.MascotsRepository>()));
  gh.factory<_i28.GetMascot>(
      () => _i28.GetMascot(gh<_i23.MascotsRepository>()));
  gh.factory<_i29.MascotAnimatorBloc>(
      () => _i29.MascotAnimatorBloc(gh<_i27.StreamMascot>()));
  gh.factory<_i30.CreateMascotBloc>(() => _i30.CreateMascotBloc(
        gh<_i3.ConvertXfileToImage>(),
        gh<_i25.SaveMascot>(),
        gh<_i28.GetMascot>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i31.HiveSingleton {}

class _$HiveExpressionsCollection extends _i32.HiveExpressionsCollection {}

class _$ExpressionsCollectionAdapter
    extends _i32.ExpressionsCollectionAdapter {}

class _$HiveSettingsCollection extends _i33.HiveSettingsCollection {}

class _$SettingsHiveCollectionAdapter
    extends _i33.SettingsHiveCollectionAdapter {}

class _$HiveMascotsCollection extends _i34.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i34.MascotsCollectionAdapter {}
