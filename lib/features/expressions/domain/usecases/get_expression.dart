import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../entities/expression.dart';
import '../repositories/expressions_repository.dart';

@injectable
class GetExpression extends UseCase<Expression, Id> {
  final ExpressionsRepository _repository;

  GetExpression(this._repository);

  @override
  FailureOrExpressionFuture call(Id params) =>
      _repository.getExpression(params);
}
