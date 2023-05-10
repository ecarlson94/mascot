import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/operators.dart';
import 'package:rxdart_ext/single.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/expression.dart';
import '../../domain/repositories/expressions_repository.dart';
import '../datasources/indexed_db/expressions_indexed_db_data_source.dart';
import '../models/expression_mapper.dart';

@Injectable(as: Logger<ExpressionsRepositoryImpl>)
class ExpressionsRepositoryLogger extends Logger<ExpressionsRepositoryImpl> {}

@Injectable(as: ExpressionsRepository)
class ExpressionsRepositoryImpl extends ExpressionsRepository {
  final ExpressionsIndexedDbDataSource _expressionsLocalDataSource;
  final ExpressionMapper _expressionMapper;
  final Logger<ExpressionsRepositoryImpl> _logger;

  ExpressionsRepositoryImpl(
    this._expressionsLocalDataSource,
    this._expressionMapper,
    this._logger,
  );

  @override
  IdsSingle saveExpressions(List<Expression> expressions) => expressions.stream
      .map(_expressionMapper.fromExpression)
      .map(_expressionsLocalDataSource.putObject)
      .flatMapBatchesSingle((value) => value, expressions.length)
      .doOnError(
        (e, s) => _logger.logError('Failed to add expressions', e, s),
      );

  @override
  ExpressionsSingle getExpressions(List<Id> ids) => _expressionsLocalDataSource
      .getObjects(ids)
      .switchMap((expressionModels) => expressionModels.stream)
      .map(_expressionMapper.toExpression)
      .flatMapBatchesSingle(Single.value, ids.length)
      .doOnError(
        (e, s) => _logger.logError('Failed to get expressions', e, s),
      );
}
