import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/data/stream_subscriber.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../../expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/indexed_db/mascots_indexed_db_data_source.dart';
import '../models/mascot_mapper.dart';
import '../models/mascot_model.dart';

@Injectable(as: Logger<MascotsRepositoryImpl>)
class MascotRepositoryLogger extends Logger<MascotsRepositoryImpl> {}

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl extends StreamSubcriber
    implements MascotsRepository {
  final MascotsIndexedDbDataSource _mascotsLocalDataSource;
  final ExpressionsIndexedDbDataSource _expressionsLocalDataSource;
  final MascotMapper _mascotMapper;
  final Logger<MascotsRepositoryImpl> _logger;

  MascotsRepositoryImpl(
    this._mascotsLocalDataSource,
    this._expressionsLocalDataSource,
    this._mascotMapper,
    this._logger,
  );

  @override
  MascotOrFailureFuture getMascot(Id id) async {
    try {
      var mascotModel = await _mascotsLocalDataSource.getObject(id);
      return Right(
        await _mapToMascotWithExpressions(mascotModel),
      );
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

      var id = await _mascotsLocalDataSource.putObject(
        _mascotMapper.fromMascot(mascot),
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
      var mascotModel = await _mascotsLocalDataSource.getObject(id);
      var mascotBehaviorSubject = BehaviorSubject<Mascot>.seeded(
        _mascotMapper.toMascot(mascotModel),
      );

      var mascotStream = _mascotsLocalDataSource.streamObject(id);
      var mascotSub = mascotStream.listen((event) async {
        var updatedMascot = event;
        mascotBehaviorSubject.add(
          await _mapToMascotWithExpressions(updatedMascot),
        );
      });
      subscriptions.add(mascotSub);

      return Right(mascotBehaviorSubject);
    } catch (e) {
      _logger.logError('Failed to stream mascot with id: $id', e);
      return Left(LocalDataSourceFailure());
    }
  }

  Future<Mascot> _mapToMascotWithExpressions(MascotModel mascotModel) async =>
      _mascotMapper.toMascot(await _fillExpressions(mascotModel));

  Future<MascotModel> _fillExpressions(MascotModel mascotModel) async {
    var expressions = await _expressionsLocalDataSource
        .getObjects(mascotModel.expressions.map((e) => e.id));

    return mascotModel.copyWith(
      expressions: expressions,
    );
  }
}
