import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../repositories/mascots_repository.dart';

@injectable
class StreamMascot implements UseCase<MascotStream, Id> {
  final MascotsRepository mascotsRepository;

  StreamMascot(this.mascotsRepository);

  @override
  MascotStream call(Id params) => mascotsRepository.streamMascot(params);
}
