import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
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
    try {
      return Right(
        // TODO: get images separately
        await _localDataSource.getMascot(id),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  @override
  FailureOrIdFuture addMascot(Mascot mascot) async {
    try {
      return Right(
        // TODO: save images separately
        await _localDataSource.addMascot(
          _mapMascotToMascotModel(mascot),
        ),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
