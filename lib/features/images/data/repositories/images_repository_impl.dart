import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/mappers/map_image_to_image_model.dart';
import '../../domain/entities/image.dart';
import '../../domain/repositories/images_repository.dart';
import '../datasources/images_local_data_source.dart';

typedef FailureOrImageFuture = Future<Either<Failure, Image>>;

@LazySingleton(as: ImagesRepository)
class ImagesRepositoryImpl implements ImagesRepository {
  final ImagesLocalDataSource _localDataSource;
  final MapImageToImageModel _mapImageToImageModel;

  ImagesRepositoryImpl(this._localDataSource, this._mapImageToImageModel);

  @override
  FailureOrImageFuture getImage(Id? id) async {
    try {
      return Right(await _localDataSource.getImage(id));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrImageFuture saveImage(Image image) async {
    try {
      return Right(
        await _localDataSource.saveImage(_mapImageToImageModel(image)),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
