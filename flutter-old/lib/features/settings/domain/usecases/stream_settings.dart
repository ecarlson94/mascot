import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../repositories/settings_repository.dart';

@injectable
class StreamSettings extends UseCase<SettingsStream, NoParams> {
  final SettingsRepository repository;

  StreamSettings(this.repository);

  @override
  SettingsStream call(NoParams params) => repository.streamSettings();
}
