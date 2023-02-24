import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';
import '../repositories/images_repository.dart';

class GetImage extends UseCase<Image, Id?> {
  final ImagesRepository _repository;

  GetImage(this._repository);

  @override
  Future<Either<Failure, Image>> call(Id? params) =>
      _repository.getImage(params);
}
