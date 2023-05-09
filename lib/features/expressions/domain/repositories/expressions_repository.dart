import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../entities/expression.dart';

typedef ExpressionsSingle = Single<List<Expression>>;

abstract class ExpressionsRepository {
  /// Adds an expression
  IdsSingle saveExpressions(List<Expression> expressions);

  /// Gets expressions by Ids
  ExpressionsSingle getExpressions(List<Id> ids);
}
