import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/expression.dart';
import '../../domain/repositories/expressions_repository.dart';
import '../datasources/drift/expressions_drift_data_source.dart';
import '../models/expression_mapper.dart';

@Injectable(as: Logger<ExpressionsRepositoryImpl>)
class ExpressionsRepositoryLogger extends Logger<ExpressionsRepositoryImpl> {}

// TODO: Add tests
@Injectable(as: ExpressionsRepository)
class ExpressionsRepositoryImpl extends ExpressionsRepository {
  final ExpressionsDriftDataSource _expressionsLocalDataSource;
  final ExpressionMapper _driftExpressionMapper;
  final Logger<ExpressionsRepositoryImpl> _logger;

  ExpressionsRepositoryImpl(
    this._expressionsLocalDataSource,
    this._driftExpressionMapper,
    this._logger,
  );

  @override
  FailureOrIdsFuture saveExpressions(Iterable<Expression> expressions) async {
    try {
      var ids = List<Id>.empty(growable: true);
      for (var expression in expressions) {
        var id = await _expressionsLocalDataSource.upsertExpression(
          _driftExpressionMapper.fromExpression(expression),
        );
        ids.add(id);
      }

      return Right(ids);
    } catch (e) {
      _logger.logError('Failed to add expressions', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  ExpressionsOrFailureFuture getExpressions(Iterable<Id> ids) async {
    try {
      var expressionModels =
          await _expressionsLocalDataSource.getExpressions(ids);

      var expressions =
          expressionModels.map(_driftExpressionMapper.toExpression).toList();

      return Right(expressions);
    } catch (e) {
      _logger.logError('Failed to get expressions with ids: $ids', e);
      return Left(LocalDataSourceFailure());
    }
  }
}