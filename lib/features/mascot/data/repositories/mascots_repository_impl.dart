import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/reactive/stream_subscriber.dart';
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
  FailureOrMascotSingle getMascot(Id id) => _mascotsLocalDataSource
      .getObject(id)
      .switchMapSingle(_toMascotWithExpressions)
      .map<FailureOrMascot>((mascot) => Right(mascot));

  @override
  FailureOrIdSingle saveMascot(Mascot mascot) {
    var hasUnsavedExpressions = mascot.expressions.any((e) => e.id == 0);
    if (hasUnsavedExpressions) {
      _logger.logError('Expressions must be saved before mascot');
      Single.value(Left(InvalidArgumentFailure()));
    }

    return Single.value(mascot)
        .map(_mascotMapper.fromMascot)
        .map(_mascotsLocalDataSource.putObject)
        .flatMapSingle((value) => value.asSingle())
        .map<FailureOrId>((event) => Right(event))
        .onErrorReturn(Left(LocalDataSourceFailure()))
        .doOnError((e, s) => _logger.logError('Failed to add mascot', e, s));
  }

  @override
  FailureOrMascotStream streamMascot(Id id) => _mascotsLocalDataSource
      .streamObject(id)
      .switchMap(_toMascotWithExpressions)
      .map<FailureOrMascot>((event) => Right(event))
      .onErrorReturn(Left(LocalDataSourceFailure()))
      .doOnError((e, s) =>
          _logger.logError('Failed to stream mascot with id: $id', e, s));

  Single<Mascot> _toMascotWithExpressions(MascotModel model) =>
      _expressionsLocalDataSource
          .getObjects(model.expressions.map((e) => e.id))
          .asSingle()
          .map((expressions) => model.copyWith(expressions: expressions))
          .map(_mascotMapper.toMascot);
}
