import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/drift/mascots_drift_data_source.dart';
import '../datasources/drift/models/drift_mascot_mapper.dart';

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  final MascotsDriftDataSource _localDataSource;
  final DriftMascotMapper _driftMascotMapper;

  MascotsRepositoryImpl(
    this._localDataSource,
    this._driftMascotMapper,
  );

  @override
  FailureOrMascotFuture getMascot(Id id) async {
    try {
      var mascotModel = await _localDataSource.getMascot(id);
      return Right(_driftMascotMapper.toMascot(mascotModel));
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrIdFuture addMascot(Mascot mascot) async {
    try {
      var id = await _localDataSource.addMascot(
        _driftMascotMapper.fromMascot(mascot),
      );

      return Right(id);
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrMascotSubjectFuture streamMascot(Id id) async {
    try {
      var mascotModel = await _localDataSource.getMascot(id);
      var mascotBehaviorSubject = BehaviorSubject<Mascot>.seeded(
        _driftMascotMapper.toMascot(mascotModel),
      );

      var mascotStream = _localDataSource.streamMascot(id);
      mascotStream.listen((event) async {
        mascotBehaviorSubject.add(
          _driftMascotMapper.toMascot(event ?? mascotModel),
        );
      });

      return Right(mascotBehaviorSubject);
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
