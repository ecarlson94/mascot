import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/services/microphone_service.dart';
import '../microphone.dart';

@Injectable(as: Logger<MicrophoneServiceImpl>)
class MicrophoneServiceImplLogger extends Logger<MicrophoneServiceImpl> {}

@LazySingleton(as: MicrophoneService)
class MicrophoneServiceImpl implements MicrophoneService {
  final Microphone _microphone;
  final Logger<MicrophoneServiceImpl> _logger;

  MicrophoneServiceImpl(this._microphone, this._logger);

  @override
  VolumeStreamOrFailureFuture getVolumeStream() async {
    try {
      if (!await _microphone.hasPermission()) {
        _logger.logError('No microphone permission');
        return Left(NoMicrophonePermissionFailure());
      }

      return Right(_microphone.volumeStream);
    } catch (e) {
      return Left(MicrophoneFailure());
    }
  }
}
