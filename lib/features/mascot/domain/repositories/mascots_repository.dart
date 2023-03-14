import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';

typedef FailureOrMascotFuture = Future<Either<Failure, Mascot>>;
typedef FailureOrMascotStreamFuture
    = Future<Either<Failure, BehaviorSubject<Mascot?>>>;

abstract class MascotsRepository {
  /// Adds a mascot
  FailureOrIdFuture addMascot(Mascot mascot);

  /// Gets a mascot by Id
  FailureOrMascotFuture getMascot(Id id);

  /// Stream of a specific mascot
  FailureOrMascotStreamFuture streamMascot(Id id);
}
