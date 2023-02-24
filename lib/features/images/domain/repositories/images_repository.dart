import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';

abstract class ImagesRepository {
  Future<Either<Failure, Image>> saveImage(Image image);
  Future<Either<Failure, Image>> getImage(Id id);
}
