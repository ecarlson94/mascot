import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class AddMascot implements UseCase<Id, Mascot> {
  final MascotsRepository _mascotsRepository;

  AddMascot(this._mascotsRepository);

  @override
  Future<Either<Failure, Id>> call(Mascot mascot) =>
      _mascotsRepository.addMascot(mascot);
}
