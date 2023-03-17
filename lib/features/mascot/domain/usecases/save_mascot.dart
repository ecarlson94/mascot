import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

typedef MascotOrFailureFuture = Future<Either<Failure, Mascot>>;

@injectable
class SaveMascot implements UseCase<Mascot, Mascot> {
  final MascotsRepository _mascotsRepository;
  final SettingsRepository _settingsRepository;

  SaveMascot(this._mascotsRepository, this._settingsRepository);

  @override
  MascotOrFailureFuture call(Mascot mascot) async {
    var idOrFailure = await _mascotsRepository.addMascot(mascot);
    return idOrFailure.fold(
      (l) => Left(l),
      (id) async {
        var mascotOrFailure = await _mascotsRepository.getMascot(id);
        return mascotOrFailure.fold(
          (l) => Left(l),
          (mascot) async => await _setInitialFavoriteMascot(mascot),
        );
      },
    );
  }

  Future<FutureOr<Either<Failure, Mascot>>> _setInitialFavoriteMascot(
      Mascot mascot) async {
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
