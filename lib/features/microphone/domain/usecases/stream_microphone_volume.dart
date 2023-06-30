import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../models/decibel_lufs.dart';
import '../services/microphone_context.dart';

@injectable
class StreamMicrophoneVolume implements UseCase<Stream<DecibelLufs>, NoParams> {
  final MicrophoneContext _microphoneService;

  StreamMicrophoneVolume(this._microphoneService);

  @override
  VolumeStream call(NoParams params) => _microphoneService.getVolumeStream();
}
