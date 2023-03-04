import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../entities/expression.dart';
import '../repositories/expressions_repository.dart';

@injectable
class AddExpression extends UseCase<Id, Expression> {
  final ExpressionsRepository _repository;

  AddExpression(this._repository);

  @override
  FailureOrIdFuture call(Expression params) =>
      _repository.addExpression(params);
}
