// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/hive/hive_collection_adapter.dart' as _i11;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/expressions/data/datasources/hive/expressions_hive_data_source.dart'
    as _i18;
import 'package:mascot/features/expressions/data/datasources/hive/models/hive_expression.dart'
    as _i10;
import 'package:mascot/features/expressions/data/datasources/hive/models/map_expression_to_hive_expression.dart'
    as _i12;
import 'package:mascot/features/expressions/data/datasources/hive/models/map_image_to_hive_image.dart'
    as _i5;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i20;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i19;
import 'package:mascot/features/mascot/data/datasources/hive/mascots_hive_data_source.dart'
    as _i21;
import 'package:mascot/features/mascot/data/datasources/hive/models/hive_mascot.dart'
    as _i8;
import 'package:mascot/features/mascot/data/datasources/hive/models/map_mascot_to_hive_mascot.dart'
    as _i13;
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
    as _i29;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i28;
import 'package:mascot/features/settings/data/datasources/hive/models/hive_settings.dart'
    as _i9;
import 'package:mascot/features/settings/data/datasources/hive/models/map_settings_to_hive_settings.dart'
    as _i6;
import 'package:mascot/features/settings/data/datasources/hive/settings_hive_data_source.dart'
    as _i14;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i16;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i15;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i17;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i25;

import '../../features/expressions/data/datasources/hive/expressions_collection.dart'
    as _i31;
import '../../features/mascot/data/datasources/hive/hive_mascots_collection.dart'
    as _i33;
import '../../features/settings/data/datasources/hive/settings_collection.dart'
    as _i32;
import 'db_configuration.dart' as _i30;

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
  final expressionsCollection = _$ExpressionsCollection();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  final settingsHiveCollectionAdapter = _$SettingsHiveCollectionAdapter();
  final expressionsCollectionAdapter = _$ExpressionsCollectionAdapter();
  gh.factory<_i3.ConvertXfileToImage>(() => _i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.factory<_i5.MapImageToHiveImage>(() => _i5.MapImageToHiveImage());
  gh.factory<_i6.MapSettingsToHiveSettings>(
      () => _i6.MapSettingsToHiveSettings());
  await gh.singletonAsync<_i7.Box<_i8.HiveMascot>>(
    () => hiveMascotsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i9.HiveSettings>>(
    () => hiveSettingsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i10.HiveExpression>>(
    () => expressionsCollection.create(gh<_i7.HiveInterface>()),
    preResolve: true,
  );
  gh.factory<_i11.HiveCollectionAdapter<_i8.HiveMascot>>(
      () => mascotsCollectionAdapter.create(gh<_i7.Box<_i8.HiveMascot>>()));
  gh.factory<_i11.HiveCollectionAdapter<_i9.HiveSettings>>(() =>
      settingsHiveCollectionAdapter.create(gh<_i7.Box<_i9.HiveSettings>>()));
  gh.factory<_i11.HiveCollectionAdapter<_i10.HiveExpression>>(() =>
      expressionsCollectionAdapter.create(gh<_i7.Box<_i10.HiveExpression>>()));
  gh.factory<_i12.MapExpressionToHiveExpression>(
      () => _i12.MapExpressionToHiveExpression(gh<_i5.MapImageToHiveImage>()));
  gh.factory<_i13.MapMascotToHiveMascot>(() =>
      _i13.MapMascotToHiveMascot(gh<_i12.MapExpressionToHiveExpression>()));
  gh.factory<_i14.SettingsHiveDataSource>(() => _i14.SettingsHiveDataSourceImpl(
        gh<_i11.HiveCollectionAdapter<_i9.HiveSettings>>(),
        gh<_i6.MapSettingsToHiveSettings>(),
      ));
  gh.factory<_i15.SettingsRepository>(() => _i16.SettingsRepositoryImpl(
        gh<_i14.SettingsHiveDataSource>(),
        gh<_i6.MapSettingsToHiveSettings>(),
      ));
  gh.factory<_i17.StreamSettings>(
      () => _i17.StreamSettings(gh<_i15.SettingsRepository>()));
  gh.factory<_i18.ExpressionsHiveDataSource>(
      () => _i18.ExpressionsHiveDataSourceImpl(
            gh<_i11.HiveCollectionAdapter<_i10.HiveExpression>>(),
            gh<_i12.MapExpressionToHiveExpression>(),
          ));
  gh.factory<_i19.ExpressionsRepository>(() => _i20.ExpressionsRepositoryImpl(
        gh<_i18.ExpressionsHiveDataSource>(),
        gh<_i12.MapExpressionToHiveExpression>(),
      ));
  gh.factory<_i21.MascotsHiveDataSource>(() => _i21.MascotsHiveDataSourceImpl(
        gh<_i11.HiveCollectionAdapter<_i8.HiveMascot>>(),
        gh<_i18.ExpressionsHiveDataSource>(),
        gh<_i13.MapMascotToHiveMascot>(),
      ));
  gh.factory<_i22.MascotsRepository>(() => _i23.MascotsRepositoryImpl(
        gh<_i21.MascotsHiveDataSource>(),
        gh<_i13.MapMascotToHiveMascot>(),
      ));
  gh.factory<_i24.SaveMascot>(() => _i24.SaveMascot(
        gh<_i22.MascotsRepository>(),
        gh<_i15.SettingsRepository>(),
      ));
  gh.factory<_i25.SettingsBloc>(
      () => _i25.SettingsBloc(gh<_i17.StreamSettings>()));
  gh.factory<_i26.StreamMascot>(
      () => _i26.StreamMascot(gh<_i22.MascotsRepository>()));
  gh.factory<_i27.GetMascot>(
      () => _i27.GetMascot(gh<_i22.MascotsRepository>()));
  gh.factory<_i28.MascotAnimatorBloc>(
      () => _i28.MascotAnimatorBloc(gh<_i26.StreamMascot>()));
  gh.factory<_i29.CreateMascotBloc>(() => _i29.CreateMascotBloc(
        gh<_i3.ConvertXfileToImage>(),
        gh<_i24.SaveMascot>(),
        gh<_i27.GetMascot>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i30.HiveSingleton {}

class _$ExpressionsCollection extends _i31.ExpressionsCollection {}

class _$ExpressionsCollectionAdapter
    extends _i31.ExpressionsCollectionAdapter {}

class _$HiveSettingsCollection extends _i32.HiveSettingsCollection {}

class _$SettingsHiveCollectionAdapter
    extends _i32.SettingsHiveCollectionAdapter {}

class _$HiveMascotsCollection extends _i33.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i33.MascotsCollectionAdapter {}
