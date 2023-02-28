import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../entities/mascot.dart';

abstract class MascotsRepository {
  /// Saves a mascot
  Future<Either<Failure, Mascot>> saveMascot(Mascot mascot);

  /// Gets a mascot by Id
  Future<Either<Failure, Stream<Mascot>>> getMascot(Id? id);
}
