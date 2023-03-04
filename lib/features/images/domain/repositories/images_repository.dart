import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';

typedef FailureOrImageFuture = Future<Either<Failure, Image>>;
typedef FailureOrIdFuture = Future<Either<Failure, Id>>;

abstract class ImagesRepository {
  /// Saves an image
  FailureOrIdFuture addImage(Image image);

  /// Gets an image by id
  FailureOrImageFuture getImage(Id? id);
}
