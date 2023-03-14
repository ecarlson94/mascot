import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/expression.dart';
import '../../domain/repositories/expressions_repository.dart';
import '../datasources/hive/expressions_hive_data_source.dart';
import '../datasources/hive/models/map_expression_to_hive_expression.dart';

@Injectable(as: ExpressionsRepository)
class ExpressionsRepositoryImpl implements ExpressionsRepository {
  final ExpressionsHiveDataSource _hiveDataSource;
  final MapExpressionToHiveExpression _mapExpressionToHiveExpression;

  ExpressionsRepositoryImpl(
    this._hiveDataSource,
    this._mapExpressionToHiveExpression,
  );

  @override
  FailureOrExpressionFuture getExpression(Id id) async {
    try {
      var expressionModel = await _hiveDataSource.getExpression(id);
      return Right(_mapExpressionToHiveExpression.reverse(expressionModel));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrIdFuture addExpression(Expression expression) async {
    try {
      var id = await _hiveDataSource
          .addExpression(_mapExpressionToHiveExpression.map(expression));
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
          await _hiveDataSource
              .addExpression(_mapExpressionToHiveExpression.map(expression)),
        );
      }
    } on Exception {
      for (var imageId in imageIds) {
        await _hiveDataSource.removeExpression(imageId);
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
      var expressionModels = await _hiveDataSource.getExpressions(ids);
      return Right(
        expressionModels.map(_mapExpressionToHiveExpression.reverse).toList(),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
