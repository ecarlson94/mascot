import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';

typedef FailureOrImageFuture = Future<Either<Failure, Image>>;
typedef FailureOrImagesFuture = Future<Either<Failure, List<Image>>>;

abstract class ImagesRepository {
  /// Saves an image
  FailureOrIdFuture addImage(Image image);

  /// Saves several images
  FailureOrImageIdsFuture addImages(List<Image> images);

  /// Gets an image by id
  FailureOrImageFuture getImage(Id id);

  /// Gets several images by ids
  FailureOrImagesFuture getImages(List<Id> ids);
}
