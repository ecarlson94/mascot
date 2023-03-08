import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/mascot.dart';
import '../repositories/mascots_repository.dart';

@injectable
class LoadFavoriteMascot extends UseCase<Mascot, NoParams> {
  final MascotsRepository mascotRepository;
  final SettingsRepository settingsRepository;

  LoadFavoriteMascot(this.mascotRepository, this.settingsRepository);

  @override
  FailureOrMascotFuture call(NoParams params) async {
    var settingsOrFailure = await settingsRepository.loadSettings();
    return await settingsOrFailure.fold(
      (l) async => Left(l),
      (settings) async =>
          await mascotRepository.getMascot(settings.favoriteMascotId),
    );
  }
}
