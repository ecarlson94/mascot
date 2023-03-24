import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/data/stream_subscriber.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/drift/mascots_drift_data_source.dart';
import '../datasources/drift/models/drift_mascot_mapper.dart';

@Injectable(as: Logger<MascotsRepositoryImpl>)
class MascotRepositoryLogger extends Logger<MascotsRepositoryImpl> {}

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl extends StreamSubcriber
    implements MascotsRepository {
  final MascotsDriftDataSource _mascotsLocalDataSource;
  final DriftMascotMapper _driftMascotMapper;
  final Logger<MascotsRepositoryImpl> _logger;

  MascotsRepositoryImpl(
    this._mascotsLocalDataSource,
    this._driftMascotMapper,
    this._logger,
  );

  @override
  MascotOrFailureFuture getMascot(Id id) async {
    try {
      var mascotModel = await _mascotsLocalDataSource.getMascot(id);
      return Right(_driftMascotMapper.toMascot(mascotModel));
    } catch (e) {
      _logger.logError('Failed to get mascot with id: $id', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  FailureOrIdFuture saveMascot(Mascot mascot) async {
    try {
      var hasUnsavedExpressions = mascot.expressions.any((e) => e.id == 0);
      if (hasUnsavedExpressions) {
        _logger.logError('Expressions must be saved before mascot');
        return Left(InvalidArgumentFailure());
      }

      var id = await _mascotsLocalDataSource.upsertMascot(
        _driftMascotMapper.fromMascot(mascot),
      );

      return Right(id);
    } catch (e) {
      _logger.logError('Failed to add mascot', e);
      return Left(LocalDataSourceFailure());
    }
  }

  @override
  MascotSubjectOrFailureFuture streamMascot(Id id) async {
    try {
      var mascotModel = await _mascotsLocalDataSource.getMascot(id);
      var mascotBehaviorSubject = BehaviorSubject<Mascot>.seeded(
        _driftMascotMapper.toMascot(mascotModel),
      );

      var mascotStream = _mascotsLocalDataSource.streamMascot(id);
      var mascotSub = mascotStream.listen((event) async {
        var updatedMascot = event ?? mascotModel;
        mascotBehaviorSubject.add(_driftMascotMapper.toMascot(updatedMascot));
      });
      subscriptions.add(mascotSub);

      return Right(mascotBehaviorSubject);
    } catch (e) {
      _logger.logError('Failed to stream mascot with id: $id', e);
      return Left(LocalDataSourceFailure());
    }
  }
}
