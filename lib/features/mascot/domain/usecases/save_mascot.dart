import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class SaveMascot implements UseCase<Id, Mascot> {
  final MascotsRepository _mascotsRepository;

  SaveMascot(this._mascotsRepository);

  @override
  FailureOrIdFuture call(Mascot mascot) => _mascotsRepository.addMascot(mascot);
}
