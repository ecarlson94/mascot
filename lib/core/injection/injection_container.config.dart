// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i9;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/collection_adapter.dart' as _i12;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart' as _i5;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i14;
import 'package:mascot/features/images/data/models/image_model.dart' as _i10;
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart'
    as _i16;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i15;
import 'package:mascot/features/images/domain/usecases/add_image.dart' as _i18;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i19;
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart'
    as _i20;
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart'
    as _i17;
import 'package:mascot/features/mascot/data/models/mascot_model.dart' as _i11;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i7;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i6;
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart' as _i8;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i13;

import '../../features/images/data/datasources/images_collection.dart' as _i22;
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
  final hiveImagesCollection = _$HiveImagesCollection();
  final hiveMascotsCollection = _$HiveMascotsCollection();
  final imagesCollectionAdapter = _$ImagesCollectionAdapter();
  final mascotsCollectionAdapter = _$MascotsCollectionAdapter();
  gh.singleton<_i3.ConvertXfileToImage>(_i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.singleton<_i5.MapImageToImageModel>(_i5.MapImageToImageModel());
  gh.lazySingleton<_i6.MascotsRepository>(() => _i7.MascotsRepositoryImpl());
  gh.lazySingleton<_i8.AddMascot>(
      () => _i8.AddMascot(gh<_i6.MascotsRepository>()));
  await gh.factoryAsync<_i9.Box<_i10.ImageModel>>(
    () => hiveImagesCollection.create(gh<_i9.HiveInterface>()),
    preResolve: true,
  );
  await gh.factoryAsync<_i9.Box<_i11.MascotModel>>(
    () => hiveMascotsCollection.create(gh<_i9.HiveInterface>()),
    preResolve: true,
  );
  gh.lazySingleton<_i12.CollectionAdapter<_i10.ImageModel>>(
      () => imagesCollectionAdapter.create(gh<_i9.Box<_i10.ImageModel>>()));
  gh.lazySingleton<_i12.CollectionAdapter<_i11.MascotModel>>(
      () => mascotsCollectionAdapter.create(gh<_i9.Box<_i11.MascotModel>>()));
  gh.lazySingleton<_i13.GetMascot>(
      () => _i13.GetMascot(gh<_i6.MascotsRepository>()));
  gh.lazySingleton<_i14.ImagesLocalDataSource>(() =>
      _i14.ImagesLocalDataSourceImpl(
          gh<_i12.CollectionAdapter<_i10.ImageModel>>()));
  gh.lazySingleton<_i15.ImagesRepository>(() => _i16.ImagesRepositoryImpl(
        gh<_i14.ImagesLocalDataSource>(),
        gh<_i5.MapImageToImageModel>(),
      ));
  gh.lazySingleton<_i17.MascotLocalDataSource>(() =>
      _i17.MascotsLocalDataSourceImpl(
          gh<_i12.CollectionAdapter<_i11.MascotModel>>()));
  gh.lazySingleton<_i18.AddImage>(
      () => _i18.AddImage(gh<_i15.ImagesRepository>()));
  gh.lazySingleton<_i19.GetImage>(
      () => _i19.GetImage(gh<_i15.ImagesRepository>()));
  gh.factory<_i20.ImageBloc>(() => _i20.ImageBloc(
        gh<_i19.GetImage>(),
        gh<_i18.AddImage>(),
        gh<_i3.ConvertXfileToImage>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i21.HiveSingleton {}

class _$HiveImagesCollection extends _i22.HiveImagesCollection {}

class _$ImagesCollectionAdapter extends _i22.ImagesCollectionAdapter {}

class _$HiveMascotsCollection extends _i23.HiveMascotsCollection {}

class _$MascotsCollectionAdapter extends _i23.MascotsCollectionAdapter {}
