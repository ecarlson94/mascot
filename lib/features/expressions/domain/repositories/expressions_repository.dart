import 'package:dartz/dartz.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../entities/expression.dart';

typedef FailureOrExpressionFuture = Future<Either<Failure, Expression>>;
typedef FailureOrExpressionsFuture = Future<Either<Failure, List<Expression>>>;

abstract class ExpressionsRepository {
  /// Saves an expression
  FailureOrIdFuture addExpression(Expression image);

  /// Saves several expressions
  FailureOrIdsFuture addExpressions(List<Expression> images);

  /// Gets an expression by id
  FailureOrExpressionFuture getExpression(Id id);

  /// Gets several expressions by ids
  FailureOrExpressionsFuture getExpressions(List<Id> ids);
}
