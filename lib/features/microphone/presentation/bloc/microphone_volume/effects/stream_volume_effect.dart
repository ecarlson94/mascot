import 'package:injectable/injectable.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../../core/clean_architecture/usecase.dart';
import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../domain/usecases/stream_microphone_volume.dart';
import '../microphone_volume_bloc.dart';

@injectable
class StreamVolumeEffect extends BlocEffect<MicrophoneVolumeEvent,
    InitializeMicrophoneVolumeEvent, MicrophoneVolumeState> {
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  StreamVolumeEffect(this._streamMicrophoneVolume);

  @override
  Stream<MicrophoneVolumeEvent> call(
    InitializeMicrophoneVolumeEvent event,
    MicrophoneVolumeState state,
  ) =>
      _streamMicrophoneVolume(NoParams())
          .map<MicrophoneVolumeEvent>(
            (volume) => MicrophoneVolumeUpdatedEvent(volume),
          )
          .startWith(const LoadingVolumeStreamEvent())
          .onErrorReturnWith(
            (e, s) => e is MicrophonePermissionException
                ? const StreamVolumeFailureEvent(
                    ErrorCodes.microphonePermissionFailure,
                  )
                : const StreamVolumeFailureEvent(
                    ErrorCodes.unknownFailure,
                  ),
          );
}
