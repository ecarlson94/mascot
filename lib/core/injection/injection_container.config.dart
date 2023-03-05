// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/collection_adapter.dart' as _i9;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/expressions/data/datasources/expressions_local_data_source.dart'
    as _i10;
import 'package:mascot/features/expressions/data/models/expression_model.dart'
    as _i7;
import 'package:mascot/features/expressions/data/repositories/expressions_repository_impl.dart'
    as _i15;
import 'package:mascot/features/expressions/data/repositories/map_expression_to_expression_model.dart'
    as _i11;
import 'package:mascot/features/expressions/data/repositories/map_image_to_image_model.dart'
    as _i5;
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart'
    as _i14;
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart'
    as _i13;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i8;
import 'package:mascot/features/mascot/data/repositories/map_mascot_to_mascot_model.dart'
    as _i12;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i17;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i16;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i19;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i18;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i20;

import '../../features/expressions/data/datasources/expressions_collection.dart'
    as _i22;
import '../../features/mascot/data/datasources/mascots_collection.dart' as _i23;
import 'db_configuration.dart' as _i21;

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
  final expressionsCollectionAdapter = _$ExpressionsCollectionAdapter();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  gh.factory<_i3.ConvertXfileToImage>(() => _i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.factory<_i5.MapImageToImageModel>(() => _i5.MapImageToImageModel());
  await gh.singletonAsync<_i6.Box<_i7.ExpressionModel>>(
    () => hiveExpressionsCollection.create(gh<_i6.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i6.Box<_i8.MascotModel>>(
    () => hiveMascotsCollection.create(gh<_i6.HiveInterface>()),
    preResolve: true,
  );
  gh.factory<_i9.CollectionAdapter<_i7.ExpressionModel>>(() =>
      expressionsCollectionAdapter.create(gh<_i6.Box<_i7.ExpressionModel>>()));
  gh.factory<_i9.CollectionAdapter<_i8.MascotModel>>(
      () => mascotsCollectionAdapter.create(gh<_i6.Box<_i8.MascotModel>>()));
  gh.factory<_i10.ExpressionsLocalDataSource>(() =>
      _i10.ImagesLocalDataSourceImpl(
          gh<_i9.CollectionAdapter<_i7.ExpressionModel>>()));
  gh.factory<_i11.MapExpressionToExpressionModel>(() =>
      _i11.MapExpressionToExpressionModel(gh<_i5.MapImageToImageModel>()));
  gh.factory<_i12.MapMascotToMascotModel>(() =>
      _i12.MapMascotToMascotModel(gh<_i11.MapExpressionToExpressionModel>()));
  gh.factory<_i13.MascotsLocalDataSource>(() => _i13.MascotsLocalDataSourceImpl(
      gh<_i9.CollectionAdapter<_i8.MascotModel>>()));
  gh.factory<_i14.ExpressionsRepository>(() => _i15.ExpressionsRepositoryImpl(
        gh<_i10.ExpressionsLocalDataSource>(),
        gh<_i11.MapExpressionToExpressionModel>(),
      ));
  gh.factory<_i16.MascotsRepository>(() => _i17.MascotsRepositoryImpl(
        gh<_i13.MascotsLocalDataSource>(),
        gh<_i14.ExpressionsRepository>(),
        gh<_i12.MapMascotToMascotModel>(),
      ));
  gh.factory<_i18.SaveMascot>(
      () => _i18.SaveMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i19.GetMascot>(
      () => _i19.GetMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i20.CreateMascotBloc>(() => _i20.CreateMascotBloc(
        gh<_i3.ConvertXfileToImage>(),
        gh<_i18.SaveMascot>(),
        gh<_i19.GetMascot>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i21.HiveSingleton {}

class _$HiveExpressionsCollection extends _i22.HiveExpressionsCollection {}

class _$ExpressionsCollectionAdapter
    extends _i22.ExpressionsCollectionAdapter {}

class _$HiveMascotsCollection extends _i23.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i23.MascotsCollectionAdapter {}
