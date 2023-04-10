import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../repositories/settings_repository.dart';

@injectable
class SaveTalkingThreshold extends UseCase<Unit, DecibelLufs> {
  final SettingsRepository repository;

  SaveTalkingThreshold(this.repository);

  @override
  FailureOrUnitFuture call(DecibelLufs params) =>
      repository.setTalkingThreshold(params);
}
