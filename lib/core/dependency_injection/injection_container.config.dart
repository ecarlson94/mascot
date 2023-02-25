// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;
import 'package:mascot/core/dependency_injection/db_configuration.dart' as _i5;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart'
    as _i3;
import 'package:mascot/features/images/data/datasources/images_collection.dart'
    as _i7;
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart'
    as _i8;
import 'package:mascot/features/images/data/models/image_model.dart' as _i6;
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart'
    as _i10;
import 'package:mascot/features/images/domain/repositories/images_repository.dart'
    as _i9;
import 'package:mascot/features/images/domain/usecases/get_image.dart' as _i12;
import 'package:mascot/features/images/domain/usecases/save_image.dart' as _i11;
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart'
    as _i13;

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
  gh.singletonAsync<_i4.Isar>(() => _i5.IsarSingleton.create());
  gh.lazySingletonAsync<_i4.IsarCollection<_i6.ImageModel>>(() async =>
      _i7.IsarImagesCollection.create(await gh.getAsync<_i4.Isar>()));
  gh.lazySingletonAsync<_i8.ImagesLocalDataSource>(() async =>
      _i8.ImagesIsarDataSource(
          await gh.getAsync<_i4.IsarCollection<_i6.ImageModel>>()));
  gh.lazySingletonAsync<_i9.ImagesRepository>(() async =>
      _i10.ImagesRepositoryImpl(
          await gh.getAsync<_i8.ImagesLocalDataSource>()));
  gh.lazySingletonAsync<_i11.SaveImage>(
      () async => _i11.SaveImage(await gh.getAsync<_i9.ImagesRepository>()));
  gh.lazySingletonAsync<_i12.GetImage>(
      () async => _i12.GetImage(await gh.getAsync<_i9.ImagesRepository>()));
  gh.factoryAsync<_i13.ImageBloc>(() async => _i13.ImageBloc(
        await gh.getAsync<_i12.GetImage>(),
        await gh.getAsync<_i11.SaveImage>(),
        gh<_i3.ConvertXfileToImage>(),
      ));
  return getIt;
}
