import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../entities/image.dart';
import '../repositories/images_repository.dart';

@injectable
class AddImage extends UseCase<Id, Image> {
  final ImagesRepository _repository;

  AddImage(this._repository);

  @override
  FailureOrIdFuture call(Image params) => _repository.addImage(params);
}
