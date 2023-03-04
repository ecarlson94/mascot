import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../../expressions/domain/repositories/expressions_repository.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/mascots_local_data_source.dart';
import 'map_mascot_to_mascot_model.dart';

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  final MascotsLocalDataSource _localDataSource;
  final ExpressionsRepository _expressionsRepository;
  final MapMascotToMascotModel _mapMascotToMascotModel;

  MascotsRepositoryImpl(
    this._localDataSource,
    this._expressionsRepository,
    this._mapMascotToMascotModel,
  );

  @override
  FailureOrMascotFuture getMascot(Id id) async {
    Mascot mascot;
    try {
      mascot = await _localDataSource.getMascot(id);
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }

    var expressionIds = mascot.expressions.map((e) => e.id).toList();
    return (await _expressionsRepository.getExpressions(expressionIds)).fold(
      (l) => Left(l),
      (expressions) => Right(mascot.copyWith(expressions: expressions)),
    );
  }

  @override
  FailureOrIdFuture addMascot(Mascot mascot) async {
    return (await _expressionsRepository.addExpressions(mascot.expressions))
        .fold(
      (l) => Left(l),
      (ids) async => (await _expressionsRepository.getExpressions(ids)).fold(
        (l) => Left(l),
        (expressions) async {
          final mascotWithExpressions = mascot.copyWith(
            expressions: expressions
                .map((e) => Expression.empty.copyWith(id: e.id))
                .toList(),
          );

          try {
            return Right(await _localDataSource.addMascot(
              _mapMascotToMascotModel(mascotWithExpressions),
            ));
          } on Exception {
            return Left(
              LocalDataSourceFailure(),
            );
          }
        },
      ),
    );
  }
}
