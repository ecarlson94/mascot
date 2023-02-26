import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';
import '../repositories/images_repository.dart';

@lazySingleton
class SaveImage extends UseCase<Image, Image> {
  final ImagesRepository _repository;

  SaveImage(this._repository);

  @override
  Future<Either<Failure, Image>> call(Image params) =>
      _repository.saveImage(params);
}
