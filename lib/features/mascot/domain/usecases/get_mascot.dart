import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class GetMascot extends UseCase<Mascot, Id> {
  final MascotsRepository _mascotsRepository;

  GetMascot(this._mascotsRepository);

  @override
  MascotSingle call(Id params) => _mascotsRepository.getMascot(params);
}
