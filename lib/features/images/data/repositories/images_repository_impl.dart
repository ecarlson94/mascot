import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/image.dart';
import '../../domain/repositories/images_repository.dart';
import '../datasources/images_local_data_source.dart';
import '../models/image_model.dart';

typedef FailureOrImageFuture = Future<Either<Failure, Image>>;

@injectable
class ImagesRepositoryImpl implements ImagesRepository {
  final ImagesLocalDataSource _localDataSource;

  ImagesRepositoryImpl(this._localDataSource);

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
  FailureOrImageFuture saveImage(Image image) async {
    try {
      return Right(
        await _localDataSource.saveImage(ImageModel.fromImage(image)),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
