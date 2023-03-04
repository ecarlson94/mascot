import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';

typedef FailureOrMascotFuture = Future<Either<Failure, Mascot>>;

abstract class MascotsRepository {
  /// Saves a mascot
  FailureOrIdFuture addMascot(Mascot mascot);

  /// Gets a mascot by Id
  FailureOrMascotFuture getMascot(Id id);
}
