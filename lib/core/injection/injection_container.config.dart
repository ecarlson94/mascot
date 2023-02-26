// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/injection/db_configuration.dart' as _i5;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart' as _i6;
import 'package:mascot/features/images/data/datasources/images_collection.dart'
    as _i9;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i10;
import 'package:mascot/features/images/data/models/image_model.dart' as _i8;
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart'
    as _i12;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i11;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i14;
import 'package:mascot/features/images/domain/usecases/save_image.dart' as _i13;
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart'
    as _i15;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
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
  gh.singleton<_i3.ConvertXfileToImage>(_i3.ConvertXfileToImage());
  gh.singletonAsync<_i4.HiveInterface>(() => _i5.HiveSingleton.create());
  gh.singleton<_i6.MapImageToImageModel>(_i6.MapImageToImageModel());
  gh.singletonAsync<_i4.BoxCollection>(() async =>
      _i5.BoxCollectionSingleton.create(
          await gh.getAsync<_i4.HiveInterface>()));
  gh.lazySingletonAsync<_i7.CollectionBox<_i8.ImageModel>>(
      () async => _i9.HiveImagesCollection.create(
            await gh.getAsync<_i7.BoxCollection>(),
            await gh.getAsync<_i7.HiveInterface>(),
          ));
  gh.lazySingletonAsync<_i9.LocalImages>(() async =>
      _i9.LocalImages(await gh.getAsync<_i7.CollectionBox<_i8.ImageModel>>()));
  gh.lazySingletonAsync<_i10.ImagesLocalDataSource>(() async =>
      _i10.ImagesLocalDataSourceImpl(await gh.getAsync<_i9.LocalImages>()));
  gh.lazySingletonAsync<_i11.ImagesRepository>(
      () async => _i12.ImagesRepositoryImpl(
            await gh.getAsync<_i10.ImagesLocalDataSource>(),
            gh<_i6.MapImageToImageModel>(),
          ));
  gh.lazySingletonAsync<_i13.SaveImage>(
      () async => _i13.SaveImage(await gh.getAsync<_i11.ImagesRepository>()));
  gh.lazySingletonAsync<_i14.GetImage>(
      () async => _i14.GetImage(await gh.getAsync<_i11.ImagesRepository>()));
  gh.factoryAsync<_i15.ImageBloc>(() async => _i15.ImageBloc(
        await gh.getAsync<_i14.GetImage>(),
        await gh.getAsync<_i13.SaveImage>(),
        gh<_i3.ConvertXfileToImage>(),
      ));
  return getIt;
}
