// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i8;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/collection_adapter.dart' as _i11;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i12;
import 'package:mascot/features/images/data/models/image_model.dart' as _i9;
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart'
    as _i14;
import 'package:mascot/features/images/data/repositories/map_image_to_image_model.dart'
    as _i6;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i13;
import 'package:mascot/features/images/domain/usecases/add_image.dart' as _i18;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i20;
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart'
    as _i22;
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart'
    as _i15;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i10;
import 'package:mascot/features/mascot/data/repositories/map_expression_to_expression_model.dart'
    as _i5;
import 'package:mascot/features/mascot/data/repositories/map_mascot_to_mascot_model.dart'
    as _i7;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i17;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i16;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i19;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i21;

import '../../features/images/data/datasources/images_collection.dart' as _i24;
import '../../features/mascot/data/datasources/mascots_collection.dart' as _i25;
import 'db_configuration.dart' as _i23;

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
  final hiveImagesCollection = _$HiveImagesCollection();
  final hiveMascotsCollection = _$HiveMascotsCollection();
  final imagesCollectionAdapter = _$ImagesCollectionAdapter();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  gh.factory<_i3.ConvertXfileToImage>(() => _i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.factory<_i5.MapExpressionToExpressionModel>(
      () => _i5.MapExpressionToExpressionModel());
  gh.factory<_i6.MapImageToImageModel>(() => _i6.MapImageToImageModel());
  gh.factory<_i7.MapMascotToMascotModel>(() =>
      _i7.MapMascotToMascotModel(gh<_i5.MapExpressionToExpressionModel>()));
  await gh.singletonAsync<_i8.Box<_i9.ImageModel>>(
    () => hiveImagesCollection.create(gh<_i8.HiveInterface>()),
    preResolve: true,
  );
  await gh.singletonAsync<_i8.Box<_i10.MascotModel>>(
    () => hiveMascotsCollection.create(gh<_i8.HiveInterface>()),
    preResolve: true,
  );
  gh.factory<_i11.CollectionAdapter<_i9.ImageModel>>(
      () => imagesCollectionAdapter.create(gh<_i8.Box<_i9.ImageModel>>()));
  gh.factory<_i11.CollectionAdapter<_i10.MascotModel>>(
      () => mascotsCollectionAdapter.create(gh<_i8.Box<_i10.MascotModel>>()));
  gh.factory<_i12.ImagesLocalDataSource>(() => _i12.ImagesLocalDataSourceImpl(
      gh<_i11.CollectionAdapter<_i9.ImageModel>>()));
  gh.factory<_i13.ImagesRepository>(() => _i14.ImagesRepositoryImpl(
        gh<_i12.ImagesLocalDataSource>(),
        gh<_i6.MapImageToImageModel>(),
      ));
  gh.factory<_i15.MascotsLocalDataSource>(() => _i15.MascotsLocalDataSourceImpl(
      gh<_i11.CollectionAdapter<_i10.MascotModel>>()));
  gh.factory<_i16.MascotsRepository>(() => _i17.MascotsRepositoryImpl(
        gh<_i15.MascotsLocalDataSource>(),
        gh<_i7.MapMascotToMascotModel>(),
      ));
  gh.factory<_i18.AddImage>(() => _i18.AddImage(gh<_i13.ImagesRepository>()));
  gh.factory<_i19.AddMascot>(
      () => _i19.AddMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i20.GetImage>(() => _i20.GetImage(gh<_i13.ImagesRepository>()));
  gh.factory<_i21.GetMascot>(
      () => _i21.GetMascot(gh<_i16.MascotsRepository>()));
  gh.factory<_i22.ImageBloc>(() => _i22.ImageBloc(
        gh<_i20.GetImage>(),
        gh<_i18.AddImage>(),
        gh<_i3.ConvertXfileToImage>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i23.HiveSingleton {}

class _$HiveImagesCollection extends _i24.HiveImagesCollection {}

class _$ImagesCollectionAdapter extends _i24.ImagesCollectionAdapter {}

class _$HiveMascotsCollection extends _i25.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i25.MascotsCollectionAdapter {}
