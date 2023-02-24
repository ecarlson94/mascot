import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';
import '../repositories/images_repository.dart';

class SaveImage extends UseCase<Image, Image> {
  final ImagesRepository _repository;

  SaveImage(this._repository);

  @override
  Future<Either<Failure, Image>> call(Image params) =>
      _repository.saveImage(params);
}
