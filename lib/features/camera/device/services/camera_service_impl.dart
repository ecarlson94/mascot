import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/services/camera_service.dart';

@Injectable(as: Logger<CameraServiceImpl>)
class CameraServiceImplLogger extends Logger<CameraServiceImpl> {}

@LazySingleton(as: CameraService)
class CameraServiceImpl extends CameraService {
  final Logger<CameraServiceImpl> _logger;

  List<CameraDescription>? _cameras;

  CameraServiceImpl(this._logger);

  @override
  Single<List<CameraDescription>> get cameras => Single.fromCallable(() async {
        _cameras ??= await availableCameras();
        return _cameras!;
      }).doOnError(
        (e, s) => _logger.logError('Failed to get cameras', e, s),
      );
}
