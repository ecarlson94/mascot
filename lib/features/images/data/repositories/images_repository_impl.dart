import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/image.dart';
import '../../domain/repositories/images_repository.dart';
import '../datasources/images_local_data_source.dart';
import 'map_image_to_image_model.dart';

@Injectable(as: ImagesRepository)
class ImagesRepositoryImpl implements ImagesRepository {
  final ImagesLocalDataSource _localDataSource;
  final MapImageToImageModel _mapImageToImageModel;

  ImagesRepositoryImpl(this._localDataSource, this._mapImageToImageModel);

  @override
  FailureOrImageFuture getImage(Id id) async {
    try {
      return Right(await _localDataSource.getImage(id));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrIdFuture addImage(Image image) async {
    try {
      return Right(
        await _localDataSource.addImage(_mapImageToImageModel(image)),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrImageIdsFuture addImages(List<Image> images) async {
    var imageIds = <Id>[];
    try {
      for (var image in images) {
        imageIds.add(
          await _localDataSource.addImage(_mapImageToImageModel(image)),
        );
      }
    } on Exception {
      for (var imageId in imageIds) {
        await _localDataSource.removeImage(imageId);
      }
      return Left(
        LocalDataSourceFailure(),
      );
    }

    return Right(imageIds);
  }

  @override
  FailureOrImagesFuture getImages(List<Id> ids) async {
    try {
      return Right(await _localDataSource.getImages(ids));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
