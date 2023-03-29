import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/expression.dart';

typedef ExpressionsOrFailureFuture = Future<Either<Failure, List<Expression>>>;

abstract class ExpressionsRepository {
  /// Adds an expression
  FailureOrIdsFuture saveExpressions(Iterable<Expression> expressions);

  /// Gets expressions by Ids
  ExpressionsOrFailureFuture getExpressions(Iterable<Id> ids);
}
