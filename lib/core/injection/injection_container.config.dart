// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart' as _i5;
import 'package:mascot/features/images/data/datasources/images_collection.dart'
    as _i8;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i9;
import 'package:mascot/features/images/data/models/image_model.dart' as _i7;
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart'
    as _i11;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i10;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i13;
import 'package:mascot/features/images/domain/usecases/save_image.dart' as _i12;
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart'
    as _i14;

import '../../features/images/data/datasources/images_collection.dart' as _i16;
import 'db_configuration.dart' as _i15;

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
  gh.singleton<_i3.ConvertXfileToImage>(_i3.ConvertXfileToImage());
  await gh.factoryAsync<_i4.HiveInterface>(
    () => hiveSingleton.create(),
    preResolve: true,
  );
  gh.singleton<_i5.MapImageToImageModel>(_i5.MapImageToImageModel());
  await gh.factoryAsync<_i6.Box<_i7.ImageModel>>(
    () => hiveImagesCollection.create(gh<_i6.HiveInterface>()),
    preResolve: true,
  );
  gh.lazySingleton<_i8.LocalImages>(
      () => _i8.LocalImages(gh<_i6.Box<_i7.ImageModel>>()));
  gh.lazySingleton<_i9.ImagesLocalDataSource>(
      () => _i9.ImagesLocalDataSourceImpl(gh<_i8.LocalImages>()));
  gh.lazySingleton<_i10.ImagesRepository>(() => _i11.ImagesRepositoryImpl(
        gh<_i9.ImagesLocalDataSource>(),
        gh<_i5.MapImageToImageModel>(),
      ));
  gh.lazySingleton<_i12.SaveImage>(
      () => _i12.SaveImage(gh<_i10.ImagesRepository>()));
  gh.lazySingleton<_i13.GetImage>(
      () => _i13.GetImage(gh<_i10.ImagesRepository>()));
  gh.factory<_i14.ImageBloc>(() => _i14.ImageBloc(
        gh<_i13.GetImage>(),
        gh<_i12.SaveImage>(),
        gh<_i3.ConvertXfileToImage>(),
      ));
  return getIt;
}

class _$HiveSingleton extends _i15.HiveSingleton {}

class _$HiveImagesCollection extends _i16.HiveImagesCollection {}
