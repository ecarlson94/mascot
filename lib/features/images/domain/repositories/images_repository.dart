import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

import '../../../../core/error/failure.dart';
import '../entities/image.dart';

abstract class ImagesRepository {
  /// Saves an image
  Future<Either<Failure, Image>> saveImage(Image image);
  Future<Either<Failure, Image>> getImage(Id id);
}
