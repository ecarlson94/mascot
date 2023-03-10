import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../../core/error/failure.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../../expressions/domain/repositories/expressions_repository.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';
import '../datasources/hive/mascots_hive_data_source.dart';
import '../models/map_mascot_to_mascot_model.dart';
import '../models/mascot_model.dart';

@Injectable(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  final MascotsHiveDataSource _localDataSource;
  final ExpressionsRepository _expressionsRepository;
  final SettingsRepository _settingsRepository;
  final MapMascotToMascotModel _mapMascotToMascotModel;

  MascotsRepositoryImpl(
    this._localDataSource,
    this._expressionsRepository,
    this._settingsRepository,
    this._mapMascotToMascotModel,
  );

  @override
  FailureOrMascotFuture getMascot(Id id) async {
    MascotModel mascotModel;
    try {
      mascotModel = await _localDataSource.getMascot(id);
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }

    return await _applyExpressions(mascotModel);
  }

  @override
  FailureOrIdFuture addMascot(Mascot mascot) async {
    return (await _expressionsRepository.addExpressions(
      mascot.expressions.toList(),
    ))
        .fold(
      (l) => Left(l),
      (ids) async => (await _expressionsRepository.getExpressions(ids)).fold(
        (l) => Left(l),
        (expressions) async {
          final mascotWithExpressions = mascot.copyWith(
            expressions: expressions
                .map((e) => Expression.empty.copyWith(id: e.id))
                .toSet(),
          );

          var failureOrSettings = await _settingsRepository.loadSettings();
          return failureOrSettings.fold(
            (l) => Left(l),
            (r) async {
              try {
                var id = await _localDataSource.addMascot(
                  await _mapMascotToMascotModel(mascotWithExpressions),
                );

                if (r.favoriteMascotId == 0) {
                  await _settingsRepository.setFavoriteMascotId(id);
                }

                return Right(id);
              } on Exception {
                return Left(
                  LocalDataSourceFailure(),
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  FailureOrMascotStreamFuture streamMascot(Id id) async {
    try {
      var failureOrMascot = await getMascot(id);
      return await failureOrMascot.fold(
        (l) => Left(l),
        (mascot) async {
          var mascotBehaviorSubject = BehaviorSubject<Mascot?>.seeded(
            mascot,
          );

          var mascotStream = await _localDataSource.streamMascot(id);
          mascotStream.listen((event) async {
            if (event == null) return;

            var failureOrMascot = await _applyExpressions(event);
            failureOrMascot.fold(
              (l) => mascotBehaviorSubject.addError(l),
              (mascot) => mascotBehaviorSubject.add(mascot),
            );
          });

          return Right(mascotBehaviorSubject);
        },
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }

  // TODO: Move this to MascotsHiveDataSourceImpl
  Future<Either<Failure, Mascot>> _applyExpressions(
    MascotModel mascotModel,
  ) async {
    try {
      List<Id> expressionIds =
          mascotModel.expressions.map((e) => e.id).toList();

      if (expressionIds.isEmpty) return Right(mascotModel);

      var failureOrExpressions =
          await _expressionsRepository.getExpressions(expressionIds);
      return failureOrExpressions.fold(
        (l) => Left(l),
        (expressions) => Right(
          mascotModel.copyWith(expressions: expressions.toSet()),
        ),
      );
    } on Exception {
      return Left(
        LocalDataSourceFailure(),
      );
    }
  }
}
