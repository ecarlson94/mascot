import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/hive/mascots_hive_data_source.dart';
import '../datasources/hive/models/map_mascot_to_hive_mascot.dart';

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  final MascotsHiveDataSource _localDataSource;
  final MapMascotToHiveMascot _mapMascotToHiveMascot;

  MascotsRepositoryImpl(
    this._localDataSource,
    this._mapMascotToHiveMascot,
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
        _mapMascotToHiveMascot.map(mascot),
      );

      return Right(id);
    } on Exception {
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrMascotStreamFuture streamMascot(Id id) async {
    try {
      var mascot = await _localDataSource.getMascot(id);
      var mascotSubject = BehaviorSubject.seeded(mascot);

      var mascotStream = await _localDataSource.streamMascot(id);
      mascotStream.listen((mascotModel) {
        if (mascotModel != null) {
          mascotSubject.add(mascotModel);
        }
      });

      return Right(mascotSubject);
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
