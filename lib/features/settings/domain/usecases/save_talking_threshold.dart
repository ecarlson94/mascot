import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../repositories/settings_repository.dart';

@injectable
class SaveTalkingThreshold extends UseCase<UnitSingle, DecibelLufs> {
  final SettingsRepository _repository;

  SaveTalkingThreshold(this._repository);

  @override
  UnitSingle call(DecibelLufs params) =>
      _repository.setTalkingThreshold(params);
}
