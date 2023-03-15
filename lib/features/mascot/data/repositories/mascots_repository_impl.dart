import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/drift/mascots_drift_data_source.dart';
import '../datasources/drift/models/map_mascot_to_drift_mascot.dart';

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  final MascotsDriftDataSource _localDataSource;
  final MapMascotToDriftMascot _mapMascotToMascotModel;

  MascotsRepositoryImpl(
    this._localDataSource,
    this._mapMascotToMascotModel,
  );

  @override
  FailureOrMascotFuture getMascot(Id id) async {
    try {
      var mascotModel = await _localDataSource.getMascot(id);
      return Right(mascotModel);
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrIdFuture addMascot(Mascot mascot) async {
    try {
      var id = await _localDataSource.addMascot(
        _mapMascotToMascotModel.map(mascot),
      );

      return Right(id);
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrMascotSubjectFuture streamMascot(Id id) async {
    try {
      return Right(await _localDataSource.streamMascot(id));
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
