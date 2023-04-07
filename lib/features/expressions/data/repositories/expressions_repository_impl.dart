import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
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
  FailureOrIdsFuture saveExpressions(Iterable<Expression> expressions) async {
    try {
      var ids = List<Id>.empty(growable: true);
      for (var expression in expressions) {
        var id = await _expressionsLocalDataSource.putObject(
          _expressionMapper.fromExpression(expression),
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
          await _expressionsLocalDataSource.getObjects(ids.toList());

      var expressions =
          expressionModels.map(_expressionMapper.toExpression).toList();

      return Right(expressions);
    } catch (e) {
      _logger.logError('Failed to get expressions with ids: $ids', e);
      return Left(LocalDataSourceFailure());
    }
  }
}
