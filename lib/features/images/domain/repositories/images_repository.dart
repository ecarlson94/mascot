import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';

abstract class ImagesRepository {
  /// Saves an image
  Future<Either<Failure, Image>> saveImage(Image image);

  /// Gets an image by id
  // TODO: change to stream
  Future<Either<Failure, Image>> getImage(Id? id);
}
