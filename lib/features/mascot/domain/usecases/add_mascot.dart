import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../../expressions/domain/repositories/expressions_repository.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

class AddMascotParams {
  final String name;
  final Expression neutralExpression;

  AddMascotParams(this.name, this.neutralExpression);
}

@Injectable(as: Logger<AddMascot>)
class AddMascotLogger extends Logger<AddMascot> {}

@injectable
class AddMascot implements UseCase<Mascot, Mascot> {
  final MascotsRepository _mascotsRepository;
  final ExpressionsRepository _expressionsRepository;
  final SettingsRepository _settingsRepository;
  final Logger<AddMascot> _logger;

  AddMascot(
    this._mascotsRepository,
    this._expressionsRepository,
    this._settingsRepository,
    this._logger,
  );

  @override
  FailureOrMascotSingle call(Mascot params) async {
    if (params.id != 0) {
      _logger.logError('Cannot add a mascot that already exists');
      return Left(InvalidArgumentFailure());
    }

    return await _saveExpressions(
      params,
      (mascot) => _saveMascot(
        mascot,
        (mascot) => _setInitialFavoriteMascot(mascot),
      ),
    );
  }

  FailureOrMascotSingle _saveExpressions(
    Mascot params,
    FailureOrMascotSingle Function(Mascot mascot) onComplete,
  ) async {
    var expressionIdsOrFailure = await _expressionsRepository.saveExpressions(
      params.expressions.toList(),
    );
    return expressionIdsOrFailure.fold(
      (l) => Left(l),
      (expressionIds) async {
        var mascot = params.copyWith(
          expressions: expressionIds
              .map((id) => Expression.empty.copyWith(id: id))
              .toSet(),
        );

        return await onComplete(mascot);
      },
    );
  }

  FailureOrMascotSingle _saveMascot(
    Mascot mascot,
    FailureOrMascotSingle Function(Mascot mascot) onComplete,
  ) async {
    var idOrFailure = await _mascotsRepository.saveMascot(mascot);
    return idOrFailure.fold(
      (l) => Left(l),
      (id) async {
        var mascotOrFailure = await _mascotsRepository.getMascot(id);
        return mascotOrFailure.fold(
          (l) => Left(l),
          (mascot) async => await onComplete(mascot),
        );
      },
    );
  }

  FailureOrMascotSingle _setInitialFavoriteMascot(
    Mascot mascot,
  ) async {
    var settingsOrFailure = await _settingsRepository.loadSettings();
    return settingsOrFailure.fold(
      (l) => Left(l),
      (settings) async {
        if (settings.favoriteMascotId != null) return Right(mascot);

        await _settingsRepository.setFavoriteMascotId(mascot.id);
        return Right(mascot);
      },
    );
  }
}
