import 'package:injectable/injectable.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

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
  Single<bool> hasPermission() => _microphone.hasPermission().doOnError(
      (e, s) => _logger.logError('Failed to check permission', e, s));

  @override
  VolumeStream getVolumeStream() => hasPermission()
      .switchMap(
        (hasPermission) => hasPermission
            ? _microphone.volumeStream
            : Stream<DecibelLufs>.error(const MicrophonePermissionException()),
      )
      .doOnError((e, s) => _logger.logError('Failed to stream volume', e, s));
}
