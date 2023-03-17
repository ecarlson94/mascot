import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class SaveMascot implements UseCase<Id, Mascot> {
  final MascotsRepository _mascotsRepository;
  final SettingsRepository _settingsRepository;

  SaveMascot(this._mascotsRepository, this._settingsRepository);

  @override
  FailureOrIdFuture call(Mascot mascot) async {
    var failureOrId = await _mascotsRepository.addMascot(mascot);
    return failureOrId.fold(
      (l) => Left(l),
      (id) async {
        var failureOrSettings = await _settingsRepository.loadSettings();
        return failureOrSettings.fold(
          (l) => Right(id),
          (settings) async {
            if (settings.favoriteMascotId != null) return Right(id);

            var failureOrSettings =
                await _settingsRepository.setFavoriteMascotId(id);
            return failureOrSettings.fold(
              (l) => Right(id),
              (r) => Right(id),
            );
          },
        );
      },
    );
  }
}
