import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

class SaveMascot implements UseCase<Mascot, Mascot> {
  final MascotsRepository _mascotsRepository;

  SaveMascot(this._mascotsRepository);

  @override
  Future<Either<Failure, Mascot>> call(Mascot mascot) =>
      _mascotsRepository.saveMascot(mascot);
}
