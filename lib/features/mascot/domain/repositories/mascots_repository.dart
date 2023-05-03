import 'package:dartz/dartz.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';

typedef FailureOrMascot = Either<Failure, Mascot>;
typedef FailureOrMascotSingle = Single<FailureOrMascot>;
typedef FailureOrMascotStream = Stream<FailureOrMascot>;

abstract class MascotsRepository {
  /// Adds a mascot
  FailureOrIdSingle saveMascot(Mascot mascot);

  /// Gets a mascot by Id
  FailureOrMascotSingle getMascot(Id id);

  /// Stream of a specific mascot
  FailureOrMascotStream streamMascot(Id id);
}
