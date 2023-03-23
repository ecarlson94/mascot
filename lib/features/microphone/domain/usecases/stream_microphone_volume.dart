import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../models/decibel_lufs.dart';
import '../services/microphone_service.dart';

@injectable
class StreamMicrophoneVolume implements UseCase<Stream<DecibelLufs>, NoParams> {
  final MicrophoneService _microphoneService;

  StreamMicrophoneVolume(this._microphoneService);

  @override
  VolumeStreamOrFailureFuture call(NoParams params) =>
      _microphoneService.getVolumeStream();
}
