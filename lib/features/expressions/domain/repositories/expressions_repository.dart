import 'package:dartz/dartz.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/expression.dart';

typedef FailureOrExpressions = Either<Failure, List<Expression>>;
typedef FailureOrExpressionsSingle = Single<FailureOrExpressions>;

abstract class ExpressionsRepository {
  /// Adds an expression
  FailureOrIdsSingle saveExpressions(List<Expression> expressions);

  /// Gets expressions by Ids
  FailureOrExpressionsSingle getExpressions(List<Id> ids);
}
