import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/expression.dart';
import '../../domain/repositories/expressions_repository.dart';
import '../datasources/expressions_local_data_source.dart';
import 'map_expression_to_expression_model.dart';

@Injectable(as: ExpressionsRepository)
class ExpressionsRepositoryImpl implements ExpressionsRepository {
  final ExpressionsLocalDataSource _localDataSource;
  final MapExpressionToExpressionModel _mapExpressionToExpressionModel;

  ExpressionsRepositoryImpl(
    this._localDataSource,
    this._mapExpressionToExpressionModel,
  );

  @override
  FailureOrExpressionFuture getExpression(Id id) async {
    try {
      var expressionModel = await _localDataSource.getExpression(id);
      return Right(_mapExpressionToExpressionModel.reverse(expressionModel));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrIdFuture addExpression(Expression expression) async {
    try {
      var id = await _localDataSource
          .addExpression(_mapExpressionToExpressionModel(expression));
      return Right(id);
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrIdsFuture addExpressions(List<Expression> expressions) async {
    var imageIds = <Id>[];
    try {
      for (var expression in expressions) {
        imageIds.add(
          await _localDataSource
              .addExpression(_mapExpressionToExpressionModel(expression)),
        );
      }
    } on Exception {
      for (var imageId in imageIds) {
        await _localDataSource.removeExpression(imageId);
      }
      return Left(
        LocalDataSourceFailure(),
      );
    }

    return Right(imageIds);
  }

  @override
  FailureOrExpressionsFuture getExpressions(List<Id> ids) async {
    try {
      var expressionModels = await _localDataSource.getExpressions(ids);
      return Right(
        expressionModels.map(_mapExpressionToExpressionModel.reverse).toList(),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
