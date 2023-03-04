import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';

typedef FailureOrImageFuture = Future<Either<Failure, Image>>;

abstract class ImagesRepository {
  /// Saves an image
  FailureOrIdFuture addImage(Image image);

  /// Gets an image by id
  FailureOrImageFuture getImage(Id id);
}
