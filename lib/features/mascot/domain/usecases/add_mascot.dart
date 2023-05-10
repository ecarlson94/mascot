import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/exception.dart';
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
class AddMascot implements UseCase<MascotSingle, Mascot> {
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
  MascotSingle call(Mascot params) {
    if (params.id != 0) {
      const exception =
          ArgumentException('Cannot add a mascot that already exists');
      _logger.logError(exception.message, exception);
      throw exception;
    }

    return _expressionsRepository
        .saveExpressions(params.expressions.toList())
        .map((expressionIds) => expressionIds
            .map((id) => Expression.empty.copyWith(id: id))
            .toSet())
        .switchMapSingle((expressions) => _mascotsRepository
            .saveMascot(params.copyWith(expressions: expressions)))
        .switchMapSingle((id) => _mascotsRepository.getMascot(id))
        .flatMapSingle(_setInitialFavoriteMascot);
  }

  Single<Mascot> _setInitialFavoriteMascot(Mascot mascot) =>
      _settingsRepository.loadSettings().flatMapSingle(
            (settings) => settings.favoriteMascotId == null
                ? _settingsRepository
                    .setFavoriteMascotId(mascot.id)
                    .map((_) => mascot)
                : Single.value(mascot),
          );
}
