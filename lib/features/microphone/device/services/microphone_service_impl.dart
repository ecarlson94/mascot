import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/services/microphone_service.dart';
import '../web/web_microphone_impl.dart';

@LazySingleton(as: MicrophoneService)
class MicrophoneServiceImpl implements MicrophoneService {
  final WebMicrophone _microphone;

  MicrophoneServiceImpl(this._microphone);

  @override
  VolumeStreamOrFailureFuture getVolumeStream() async {
    try {
      var hasPermission = await _microphone.hasPermission();
      if (hasPermission) return Right(_microphone.volumeStream);

      return Left(NoMicrophonePermissionFailure());
    } catch (e) {
      return Left(MicrophoneFailure());
    }
  }
}
