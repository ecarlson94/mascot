import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

@injectable
class StreamSettings extends UseCase<Stream<Settings?>, NoParams> {
  final SettingsRepository repository;

  StreamSettings(this.repository);

  @override
  FailureOrSettingsStreamFuture call(NoParams params) =>
      repository.streamSettings();
}
