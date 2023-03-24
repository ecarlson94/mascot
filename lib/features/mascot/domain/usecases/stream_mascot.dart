import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class StreamMascot implements UseCase<Stream<Mascot?>, Id> {
  final MascotsRepository mascotsRepository;

  StreamMascot(this.mascotsRepository);

  @override
  MascotSubjectOrFailureFuture call(Id params) =>
      mascotsRepository.streamMascot(params);
}
